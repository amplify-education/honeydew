require 'rubygems'
require 'bundler'
Bundler.require

require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --color --format pretty"
end