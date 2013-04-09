ELEMENTS = {"button" => "Button", "text" => "TextView"}

Given /^I launch app "(.*?)"$/ do |app_name|
  Honeydew.default_device.perform_action :action => "launch_app", :arguments => {:appName => app_name}, :attempts => 3
end

Given /^I launch home$/ do
  Honeydew.default_device.perform_action :action => "launch_home"
end

Given /^I select "(.*?)" in the Settings view$/ do |menu_item|
  Honeydew.default_device.perform_action :action => "select_menu_in_settings", :arguments => {:menuName => menu_item}
end

Given /^I select app "(.*?)" from the Apps list in the Settings view$/ do |app_name|
  Honeydew.default_device.perform_action :action => "select_from_apps_list", :arguments => {:appName => app_name}
end

Given /^I should see text containing "(.*?)"$/ do |exp_text|
  Honeydew.default_device.perform_action(:action => "is_text_present", :arguments => {:text => exp_text})["success"].should be_true
end

Given /^I enter text "(.*?)" into field with description "(.*?)"$/ do |text, field_description|
  Honeydew.default_device.perform_action :action => "set_text", :arguments => {:description => field_description, :text => text}
end

Given /^I press the "(.*?)" (button|text)$/ do |button_text,element_type|
  Honeydew.default_device.perform_action :action => "click", :arguments => {:text => button_text, :type => ELEMENTS[element_type]}
end

When /^I wait up to (\d+) seconds for "(.*?)" to appear$/ do |timeout, text|
  Honeydew.default_device.perform_action :action => "is_text_present", :arguments => {:text => text}, :retry_until => timeout
end

Given /I uninstall the app "(.*?)" using ADB$/ do |pacakge_name|
  Honeydew.default_device.uninstall_app pacakge_name
end

Given /I install the app "(.*?)" using ADB$/ do |apk_location|
  Honeydew.default_device.install_app apk_location
end

Given /I reboot the device using ADB$/ do
  Honeydew.default_device.reboot
end

Then /I see the app "(.*?)" installed using ADB$/ do |pacakge_name|
  Honeydew.default_device.is_app_installed?(pacakge_name).should be_true
end

Then /I should see a button "(.*?)" with (package|description) as "(.*?)"$/ do |button_text, condition, package_name|
  Honeydew.default_device.perform_action(:action => "is_button_present", :arguments => {:text => button_text}, :retry_until => timeout)
end