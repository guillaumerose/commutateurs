module Commutateurs
  class ASA < Base
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
    end

    def configuration
      execute("terminal pager 0")
      execute('show running-config')
    end

    def save
    end

    def disconnect
      @transport.send 'exit'
      @transport.close
    end
  end
end
