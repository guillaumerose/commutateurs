# This code is nearly the same as the code below. Thanks to Puppet network device authors and net-ssh-telnet authors
# https://github.com/puppetlabs/puppet/blob/master/lib/puppet/util/network_device/transport/ssh.rb
module Commutateurs
  class Ssh
    attr_accessor :user, :password, :host, :port
    attr_accessor :default_prompt, :timeout

    def initialize(verbose = false)
      @timeout = 10
      @verbose = verbose
    end

    def command(cmd, options = {})
      send(cmd)
      expect(options[:prompt] || default_prompt) do |output|
        yield output if block_given?
      end
    end

    def connect(&block)
      @output = []
      @channel_data = ""

      @ssh = Net::SSH.start(host, user, :port => port, :password => password, :timeout => timeout)

      @buf = ""
      @eof = false
      @channel = nil
      @ssh.open_channel do |channel|
        channel.request_pty { |ch,success| raise "failed to open pty" unless success }

        channel.send_channel_request("shell") do |ch, success|
          raise "failed to open ssh shell channel" unless success

          ch.on_data { |ch,data|
            $stderr.print data if @verbose
            @buf << data
          }
          ch.on_extended_data { |ch,type,data| $stderr.print data if type == 1; @buf << data if type == 1 }
          ch.on_close { @eof = true }

          @channel = ch
          expect(default_prompt, &block)
          return
        end

      end
      @ssh.loop
    end

    def close
      Timeout::timeout(2) {
        @channel.close if @channel
        @channel = nil
        @ssh.close if @ssh
      }
    rescue Timeout::Error
    end

    def expect(prompt)
      line = ''
      sock = @ssh.transport.socket

      while not @eof
        break if line =~ prompt and @buf == ''
        break if sock.closed?

        IO::select([sock], [sock], nil, nil)

        process_ssh

        if @buf != ""
          line += @buf.gsub(/\r\n/no, "\n")
          @buf = ''
          yield line if block_given?
        elsif @eof
          # channel has been closed
          break if line =~ prompt
          if line == ''
            line = nil
            yield nil if block_given?
          end
          break
        end
      end
      line
    end

    def send(line)
      @channel.send_data(line + "\n")
    end

    private
    def eof?
      !! @eof
    end

    def process_ssh
      while @buf == "" and not eof?
        begin
          @channel.connection.process(0.1)
        rescue IOError
          @eof = true
        end
      end
    end
  end
end