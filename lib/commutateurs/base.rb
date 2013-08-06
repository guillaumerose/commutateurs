module Commutateurs
  class Base
    def initialize(host, credentials, verbose = false)
      @enable = credentials.enable

      @transport = Ssh.new(verbose)
      @transport.host = host
      @transport.user = credentials.user
      @transport.password = credentials.password
    end

    def execute(line)
      @transport.command line
    end
  end
end
