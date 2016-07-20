# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minikick/version'

Gem::Specification.new do |spec|
  spec.name          = "minikick"
  spec.version       = Minikick::VERSION
  spec.authors       = ["Rachel King"]
  spec.email         = ["rachel.b.king@gmail.com"]

  spec.summary       = %q{Mini Kickstarter.}
  spec.homepage      = "https://github.com/macroscopicentric/minikick"

  spec.files         = Dir[ '{lib,spec}/**/*.rb' ] +
                       Dir[ 'Rakefile', 'LICENSE.txt', 'README.md' ] +
                       Dir[ 'bin/*' ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "money", "~> 6.7"
  spec.add_dependency "monetize", "~> 1.4"
  spec.add_dependency "luhn", "~>1.0"
end
