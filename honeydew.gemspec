# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'honeydew/version'

Gem::Specification.new do |spec|
  spec.name          = "honeydew"
  spec.version       = Honeydew::VERSION
  spec.authors       = ["Selva", "Christopher Rex"]
  spec.email         = ["scmp-team@amplify.com"]
  spec.description   = %q{Automated functional testing on Android with uiautomator and cucumber}
  spec.summary       = %q{Automated functional testing on Android with uiautomator and cucumber}
  spec.homepage      = ""

  spec.files         = `git ls-files`.split($/) + Dir['android-server']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency("cucumber")
  spec.add_dependency("json")
  spec.add_dependency("rest-client")
  spec.add_dependency("activesupport")
end
