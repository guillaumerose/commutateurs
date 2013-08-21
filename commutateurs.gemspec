# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name = "commutateurs"
  gem.version = "0.2.0"
  gem.date = "2013-08-21"
  gem.authors = ["Guillaume Rose"]
  gem.email = "guillaume.rose@gmail.com"
  gem.summary = "Library for accessing commutateurs"
  gem.description = "Library for accessing commutateurs"
  gem.homepage = "http://www.github.com/guillaumerose/commutateurs"

  gem.files = ["lib/commutateurs/base.rb",
               "lib/commutateurs/cisco.rb",
               "lib/commutateurs/credentials.rb",
               "lib/commutateurs/fortigate.rb",
               "lib/commutateurs/h3c.rb",
               "lib/commutateurs/hp.rb",
               "lib/commutateurs/juniper.rb",
               "lib/commutateurs/brocade.rb",
               "lib/commutateurs/ssh.rb",
               "lib/commutateurs.rb"]

  gem.add_dependency('net-ssh')
  gem.license = 'MIT'
end
