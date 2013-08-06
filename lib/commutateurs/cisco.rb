module Commutateurs
  class Cisco < Base
    def initialize(host, credentials, verbose = false)
      super
      @transport.default_prompt = /[#>]\s?\z/n
    end

    def enable
      @transport.command("enable", :prompt => /^Password:/)
      @transport.command(@enable)
    end

    def connect
      @transport.connect
      @transport.command('terminal length 0')
    end

    def configuration
      execute('show run')
    end

    def save
      execute('wr mem')
    end

    def disconnect
      @transport.send 'exit'
      @transport.close
    end
  end
end
