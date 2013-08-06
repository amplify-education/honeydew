require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :server do
  desc 'build android server'
  task :build do
    system "cd #{android_server_path} && mvn clean package"
  end

  desc 'push the server to the device'
  task push: :build do
    system "adb push #{android_server_path}/target/honeydew-server-#{Honeydew::VERSION}.jar /data/local/tmp"
  end
end

def android_server_path
  File.absolute_path(File.join(File.dirname(__FILE__), 'server'))
end

task :build => [:spec, :build_android_server]
