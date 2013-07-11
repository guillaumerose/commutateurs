# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name = "commutateurs"
  gem.version = "0.0.8"
  gem.date = "2013-02-01"
  gem.authors = ["Guillaume Rose"]
  gem.email = "guillaume.rose@gmail.com"
  gem.summary = "Library for accessing commutateurs"
  gem.description = "Library for accessing commutateurs"
  gem.homepage = "http://www.github.com/guillaumerose/commutateurs"

  gem.files = ["lib/commutateurs/device.rb",
               "lib/commutateurs/ssh.rb",
               "lib/commutateurs.rb"]

  gem.add_dependency('net-ssh')
end
