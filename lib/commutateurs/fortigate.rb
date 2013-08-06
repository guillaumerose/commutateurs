module Commutateurs
  class Fortigate < Base
    def initialize(host, credentials, verbose = false)
      super
      @transport.default_prompt = / [#\$] $/
    end

    def enable
    end

    def connect
      @transport.connect
    end

    def configuration
      execute('show')
    end

    def save
    end

    def disconnect
      @transport.send 'exit'
      @transport.close
    end
  end
end
