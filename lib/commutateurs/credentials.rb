module Commutateurs
  class Credentials
    attr_reader :user, :password, :enable
    def initialize(user, password, enable)
      @user = user
      @password = password
      @enable = enable
    end
  end
end
