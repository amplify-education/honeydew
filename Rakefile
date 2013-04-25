require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "build android server"
task :build_android_server do
  system "cd #{android_server_path} && mvn clean package"
end

def android_server_path
  File.absolute_path(File.join(File.dirname(__FILE__), 'android-server'))
end

task :build => [:spec, :build_android_server]