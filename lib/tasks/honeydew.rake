require 'honeydew'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:honeydew, 'Run honeydew cucumber tests') do |t|
  t.profile = 'honeydew'
  t.cucumber_opts = "--tags @honeydew"
end