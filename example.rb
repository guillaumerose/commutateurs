require 'commutateurs'

include Commutateurs

credentials = Credentials.new("login", "password", "enable")

verbose = true
device = Cisco.new("hostname", credentials, verbose)
device.connect
device.enable

puts device.execute("sh interface status")

device.disconnect
