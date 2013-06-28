module Honeydew
  module DeviceMatchers
    def has_text?(text, timeout = Honeydew.config.timeout)
      perform_assertion :is_text_present,
        {:text => text},
        :timeout => timeout
    end

    def has_element_with_description?(description, timeout = Honeydew.config.timeout)
      perform_assertion :is_text_present,
        {:description => description},
        :timeout => timeout
    end

    def has_edit_text?(text, timeout = Honeydew.config.timeout)
      perform_assertion :is_text_present,
        {:text => text, :type => 'EditText'},
        :timeout => timeout
    end

    def has_textview_text?(text, timeout = Honeydew.config.timeout)
      perform_assertion :is_text_present,
        {:text => text, :type => 'TextView'},
        :timeout => timeout
    end

    def has_textview_with_text_and_description?(text, description, timeout = Honeydew.config.timeout)
      perform_assertion :is_text_present,
        {:text => text, :description => description, :type => 'TextView'},
        :timeout => timeout
    end

    def has_button?(button_text, timeout = Honeydew.config.timeout)
      perform_assertion :is_button_present,
        {:text => button_text},
        :timeout => timeout
    end

    def has_child_count?(parent_element_description, child_element_description, child_count, timeout = Honeydew.config.timeout)
      perform_assertion :is_child_count_equal_to,
        {:parent_description => parent_element_description,
         :child_description => child_element_description,
         :child_count => child_count},
        :timeout => timeout
    end

    def has_element_with_nested_text?(parent_description, child_text, timeout = Honeydew.config.timeout)
      perform_assertion :is_element_with_nested_text_present,
        {:parent_description => parent_description,
         :child_text => child_text},
        :timeout => timeout
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

    def has_settings_menu_item?(item_name, timeout = 10)
      perform_assertion :has_settings_menu_item,
        {:menuName => item_name},
        :timeout => timeout
    end
  end
end
