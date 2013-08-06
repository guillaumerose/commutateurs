module Commutateurs
  class H3c < Base
    def initialize(host, credentials, verbose = false)
      super
      @transport.default_prompt = /(<.*>|\[.*\])$/
    end

    def enable
      @transport.command('super', :prompt => /Password:/)
      @transport.command(@enable)
      @transport.command('screen-length disable')
    end

    def connect
      @transport.connect
    end

    def configuration
      execute('dis curr')
    end

    def save
      @transport.command('save safely', :prompt => /Are you sure/)
      @transport.command('Y', :prompt => /enter key/)
      @transport.command('')
    end

    def disconnect
      @transport.send 'quit'
      @transport.close
    end
  end
end
