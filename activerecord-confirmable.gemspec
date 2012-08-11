# -*- encoding: utf-8 -*-
require File.expand_path('../lib/activerecord-confirmable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Beyond"]
  gem.email         = ["beyond@be.to"]
  gem.description   = %q{ confirmatin view on model creation / changes }
  gem.summary       = %q{ confirmatin view without confirm action adding to controller. }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "activerecord-confirmable"
  gem.require_paths = ["lib"]
  gem.version       = Activerecord::Confirmable::VERSION

  gem.add_development_dependency "rspec"
end