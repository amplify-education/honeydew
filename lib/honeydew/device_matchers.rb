module Honeydew
  module DeviceMatchers
    def has_text?(text)
      perform_assertion :is_text_present, :text => text
    end

    def has_element_with_description?(description)
      perform_assertion :is_text_present, :description => description
    end

    def has_edit_text?(text)
      perform_assertion :is_text_present, :text => text, :type => 'EditText'
    end

    def has_textview_text?(text)
      perform_assertion :is_text_present, :text => text, :type => 'TextView'
    end

    def has_text_disappear?(text)
      perform_assertion :is_text_gone, :text => text, :type => 'TextView'
    end

    def has_textview_with_text_and_description?(text, description)
      perform_assertion :is_text_present, :text => text, :description => description, :type => 'TextView'
    end

    def has_button?(button_text)
      perform_assertion :is_button_present, :text => button_text
    end

    # TODO: Look for a better way to express these similar looking matchers
    def has_child_count?(parent_element_description, child_element_description, child_count)
      perform_assertion :is_child_count_equal_to,
        :parent_description => parent_element_description,
         :child_description => child_element_description,
         :child_count => child_count
    end

    def has_child_count_greater_than?(parent_element_description, child_element_description, child_count)
      perform_assertion :is_child_count_greater_than,
        :parent_description => parent_element_description,
         :child_description => child_element_description,
         :child_count => child_count
    end

    def has_element_with_nested_text?(parent_description, child_text)
      perform_assertion :is_element_with_nested_text_present,
        :parent_description => parent_description,
         :child_text => child_text
    end

    def has_app_installed?(package_name)
      adb('shell pm list packages').include?(package_name)
    end

    def is_option_in_setting_enabled?(item_name, option_names)
      perform_assertion :is_option_in_settings_menu_enabled,
        :menuName => item_name, :optionNames => option_names
    end

    def is_option_in_setting_disabled?(item_name, option_names)
      perform_assertion :is_option_in_settings_menu_disabled,
        :menuName => item_name, :optionNames => option_names
    end

    def has_settings_menu_item?(item_name)
      perform_assertion :has_settings_menu_item,
        :menuName => item_name
    end
  end
end
