commutateurs
============

A simple gem to manage network switches

Supported devices
----------------

* Cisco Catalyst
* H3c
* Juniper SSG
* HP Procurve (in progress)
* Fortigate

Examples
--------

```ruby
require 'commutateurs'

include Commutateurs

credentials = Credentials.new("login", "password", "enable")

verbose = true
device = Cisco.new("hostname", credentials, verbose) # or H3c.new
device.connect
device.enable

puts device.execute("sh interface status")

device.disconnect
```
