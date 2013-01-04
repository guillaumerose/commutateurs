module Commutateurs
  class Credentials
    attr_reader :user, :password, :enable
    def initialize(user, password, enable)
      @user = user
      @password = password
      @enable = enable
    end
  end

  class Base
    def initialize(host, credentials)
      @enable = credentials.enable

      @transport = Ssh.new
      @transport.host = host
      @transport.user = credentials.user
      @transport.password = credentials.password
    end

    def execute(line)
      @transport.command line
    end
  end

  class Cisco < Base
    def initialize(host, credentials)
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

  class H3c < Base
    def initialize(host, credentials)
      super
      @transport.default_prompt = /(<.*>|\[.*\])$/
    end

    def enable
      @transport.command('super', :prompt => /Password:/)
      @transport.command(@enable)
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
