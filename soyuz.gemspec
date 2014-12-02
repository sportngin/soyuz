# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soyuz/version'

Gem::Specification.new do |spec|
  spec.name          = "soyuz"
  spec.version       = Soyuz::VERSION
  spec.authors       = ["Andy Fleener"]
  spec.email         = ["andrew.fleener@sportngin.com"]
  spec.summary       = %q{The old trusty deployment toolkit}
  spec.description   = %q{Soyuz is the deployment toolkit that glues all of your deployment pipeline together}
  spec.homepage      = "https://github.com/sportngin/soyuz"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "gli"
  spec.add_dependency "highline"
  spec.add_dependency "safe_yaml"
  spec.add_dependency "psych", "2.0.6"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~>3.0.0.beta1 "
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
