require 'honeydew'

desc "Run honeydew cucumber tests"
task :honeydew do
  cucumber_opts = ENV["CUCUMBER_OPTS"]
  Honeydew.start_uiautomator_server
  status = system "bundle exec cucumber #{cucumber_opts}"
  Honeydew.terminate_uiautomator_server
  fail "Rake task failed!" unless status
end