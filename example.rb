require 'commutateurs'

include Commutateurs

credentials = Credentials.new("login", "password", "enable")

device = Cisco.new("hostname", credentials)
device.connect
device.enable

puts device.execute("sh interface status")

device.disconnect
