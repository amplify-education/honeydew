Given /^I unlock$/ do
  Honeydew.current_device.unlock
end

Given /^I launch app "(.*?)"$/ do |app_name|
  Honeydew.current_device.launch_application app_name
end

Given /^I launch home$/ do
  Honeydew.current_device.launch_home
end

Given /^I select "(.*?)" in the Settings view$/ do |menu_item|
  Honeydew.current_device.launch_settings_item menu_item
end

Given /^I select app "(.*?)" from the Apps list in the Settings view$/ do |app_name|
  Honeydew.current_device.launch_settings_app app_name
end

Given /^I should see text containing "(.*?)"$/ do |expected_test|
  Honeydew.current_device.should have_text? expected_text
end

Given /^I enter text "(.*?)" into field with description "(.*?)"$/ do |text, field_description|
  Honeydew.current_device.fill_in field_description, with: text
end

Given /^I press the "(.*?)" button$/ do |button_text|
  Honeydew.current_device.click_button button_text
end

Given /^I press the "(.*?)" text$/ do |text|
  Honeydew.current_device.click_text text
end

Given /^I press the element with description "(.*?)"$/ do |element_description|
  Honeydew.current_device.click_element element_description
end

Given /^I long press the element with description "(.*?)"$/ do |element_description|
  Honeydew.current_device.long_click_element element_description
end

When /^I wait up to (\d+) seconds for "(.*?)" to appear$/ do |timeout, text|
  Honeydew.current_device.should have_textview_text text, timeout
end

When /^I wait up to (\d+) seconds for "(.*?)" to appear in edit text$/ do |timeout, text|
  Honeydew.current_device.should have_edit_text text, timeout
end

Given /I uninstall the app "(.*?)" using ADB$/ do |pacakge_name|
  Honeydew.current_device.uninstall_app pacakge_name
end

Given /I install the app "(.*?)" using ADB$/ do |apk_location|
  Honeydew.current_device.install_app apk_location
end

Given /I reboot the device using ADB$/ do
  Honeydew.current_device.reboot
end

Then /I see the app "(.*?)" installed using ADB$/ do |package_name|
  Honeydew.current_device.should have_app_installed package_name
end

Then /I should see a button "(.*?)" with (package|description) as "(.*?)"$/ do |button_text, condition, package_name|
  Honeydew.current_device.should have_button button_text
end
