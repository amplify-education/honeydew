require 'honeydew'
Before("@honeydew") do |scenario|
  Honeydew.start_uiautomator_server
end