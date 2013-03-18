Given /^I launch app "(.*?)"$/ do |app_name|
  perform_action :action => "launch_app", :arguments => {:appName => app_name}
end

Given /^I enter text "(.*?)" into field with description "(.*?)"$/ do |text, field_description|
  perform_action :action => "set_text", :arguments => {:description => field_description, :text => text}
end

Given /^I press the "(.*?)" button$/ do |button_text|
  perform_action :action => "click_button", :arguments => {:text => button_text}
end

When /^I wait up to (\d+) seconds for "(.*?)" to appear$/ do |timeout, text|
  retry_until_success timeout, "is_text_present", :text => text
end

def perform_action(command)
  JSON.parse(RestClient.get("http://localhost:9090/", :params => stringify_keys(:command => command))).tap do |response|
    p command.inspect
    p response.inspect
  end
end

def stringify_keys(options)
  JSON.parse(options.to_json)
end

def retry_until_success(timeout, action, arguments)
  completed = false
  Timeout.timeout(timeout.to_i) do
    until completed do
      completed = perform_action(:action => action, :arguments => arguments)["success"]
      sleep 1
    end
  end
rescue Timeout::Error
  raise "Timeout while performing #{action}, with arguments: #{arguments}"
end