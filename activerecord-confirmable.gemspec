# -*- encoding: utf-8 -*-
require File.expand_path('../lib/activerecord-confirmable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Beyond"]
  gem.email         = ["beyond@be.to"]
  gem.description   = %q{ confirmatin view on model creation / changes }
  gem.summary       = %q{ confirmatin view without confirm action adding to controller. }
  gem.homepage      = "https://github.com/beyond/activerecord-confirmable"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "activerecord-confirmable"
  gem.require_paths = ["lib"]
  gem.version       = Activerecord::Confirmable::VERSION

  gem.add_runtime_dependency "activerecord"
  gem.add_runtime_dependency "activesupport"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency 'rake', '~> 0.9.2.2'
  gem.add_development_dependency 'rdoc', '~> 3.11'
  gem.add_development_dependency 'sqlite3'
end
