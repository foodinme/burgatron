# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'burgatron/version'

Gem::Specification.new do |spec|
  spec.name          = "burgatron"
  spec.version       = Burgatron::VERSION
  spec.authors       = ["Matthew Boeh"]
  spec.email         = ["matthew.boeh@gmail.com"]
  spec.description   = %q{The seething thinking machine behind foodin.me}
  spec.summary       = %q{Puts food in ya}
  spec.homepage      = "http://foodin.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "yelpster"
  spec.add_dependency "foursquare2"
  
  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", "~> 2.2.0"
end
