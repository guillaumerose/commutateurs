module Commutateurs
  class Brocade < Base
    def initialize(host, credentials, verbose = false)
      super
      @transport.default_prompt = /:admin> $/
    end

    def enable
    end

    def connect
      @transport.connect
    end

    def configuration
      execute('configshow')
    end

    def save
    end

    def disconnect
      @transport.send 'exit'
      @transport.close
    end
  end
end
