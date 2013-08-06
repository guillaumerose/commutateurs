module Commutateurs
  # Work in progress
  class HP < Base
    def initialize(host, credentials, verbose = false)
      super
      @transport.default_prompt = /(Press any key to continue|# )/
      @transport.debug = Proc.new { |line| $stderr.print(clean(line)) }
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

    def execute(arg)
      clean(super(arg))
    end

    def clean(arg)
      cleaned = ""
      (arg || "").each_byte { |x|  cleaned << x unless x > 127   }
      cleaned
    end
  end
end
