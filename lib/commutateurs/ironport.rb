module Commutateurs
  class Ironport < Base
    def initialize(host, credentials, verbose = false)
      super
      @transport.default_prompt = /> $/
      @transport.filter = Proc.new { |line| line.gsub(/\r\s*\r/, "") }
      @transport.more = /-Press Any Key For More-$/
    end

    def enable
    end

    def connect
      @transport.connect
    end

    def configuration
      execute('showconfig')
      execute('Y')
    end

    def save
    end

    def disconnect
      @transport.send 'exit'
      @transport.close
    end
  end
end
