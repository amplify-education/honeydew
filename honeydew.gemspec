# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'honeydew/version'

Gem::Specification.new do |spec|
  spec.name          = 'honeydew'
  spec.version       = Honeydew::VERSION
  spec.authors       = ['Selvakumar Natesan', 'Christopher Rex', 'Shyam Vala', 'John Barker']
  spec.email         = ['scmp-team@amplify.com', 'jbarker@amplify.com']
  spec.summary       = 'Ruby DSL for controlling Android devices'
  spec.description   = <<-EOF
Honeydew is a Ruby driver for UIAutomator which enables automated testing of
Android devices.
  EOF

  spec.files         = `git ls-files`.split($/) + Dir["server/target/honeydew-server-#{Honeydew::VERSION}*.jar"]
  spec.test_files    = spec.files.grep(/spec/)
  spec.require_paths = ['lib']

  spec.add_dependency('activesupport')
  spec.add_dependency('json')

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
