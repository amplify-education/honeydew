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
  perform_action :action => "is_text_present", :arguments => {:text => text}, :retry_until => timeout
end

Given /I uninstall the app "(.*?)" using ADB$/ do |pacakge_name|
  uninstall_app pacakge_name
end

Then /I see the app "(.*?)" installed using ADB$/ do |pacakge_name|
  is_app_installed?(pacakge_name).should be_true
end