Given /^I launch app "(.*?)"$/ do |app_name|
  perform_action :action => "launch_app", :arguments => {:appName => app_name}
end

Given /^I select "(.*?)" in the Settings view$/ do |menu_item|
  perform_action :action => "select_menu_in_settings", :arguments => {:menuName => menu_item}
end

Given /^I select app "(.*?)" from the Apps list in the Settings view$/ do |app_name|
  perform_action :action => "select_from_apps_list", :arguments => {:appName => app_name}
end

Given /^I should see text containing "(.*?)"$/ do |exp_text|
  perform_action(:action => "is_text_present", :arguments => {:text => exp_text})["success"].should be_true
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

Then /I should see a button "(.*?)" with (package|description) as "(.*?)"$/ do |button_text, condition, package_name|
  perform_action(:action => "is_button_present", :arguments => {:text => button_text}, :retry_until => timeout)
end