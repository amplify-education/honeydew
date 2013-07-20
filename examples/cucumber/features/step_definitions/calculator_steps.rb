require 'honeydew'

When(/^I launch app (.+)$/) do |app|
  Honeydew.current_device.launch_application app
end

Then(/^I square root (\d+)/) do |number|
  Honeydew.current_device.long_click_element 'square root'
  number.to_s.each_char {|n| Honeydew.current_device.click_button n }
  Honeydew.current_device.click_button '='
end

When(/^I press the (.+) button$/) do |text|
  Honeydew.current_device.click_button text
end

Then(/^I should see (\d+) as the result$/) do |result|
  Honeydew.current_device.should have_edit_text(result)
end