module Commutateurs
  # Work in progress
  class HP < Base
    def initialize(host, credentials, verbose = false)
      super
      @transport.default_prompt = /(Press any key to continue|# )/

      # hpuifilter.c used by rancid - https://github.com/dotwaffle/rancid-git/blob/master/bin/hpuifilter.c#L534
      @transport.filter = Proc.new do |line| 
        line.gsub(/\e\[2K|\e\[2J|\e\[\?7l|\e\[\?6l|\e\[[0-9]+;[0-9]+r|\e\[[0-9]+;[0-9]+H|\e\[\?25l|\e\[\?25h/, "")
            .gsub(/\eE/, "\n") 
      end
    end

    def connect
      @transport.connect
      @transport.command("\n")
      @transport.command("terminal length 1000")
    end

    def enable

    end

    def configuration
      execute('write term')
    end

    def save
      execute('write memory')
    end

    def disconnect
      @transport.send 'exit'
      @transport.close
    end
  end
end
