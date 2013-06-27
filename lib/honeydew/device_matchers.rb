module Honeydew
  module DeviceMatchers

    def has_text?(text, timeout = Honeydew.config.timeout)
      perform_action :action => 'is_text_present', :arguments => {:text => text}, :retry_until => timeout
    end

    def has_element_with_description?(description, timeout = Honeydew.config.timeout)
      perform_action :action => 'is_text_present', :arguments => {:description => description}, :retry_until => timeout
    end

    def has_edit_text?(text, timeout = Honeydew.config.timeout)
      perform_action :action => 'is_text_present', :arguments => {:text => text, :type => 'EditText'}, :retry_until => timeout
    end

    def has_textview_text?(text, timeout = Honeydew.config.timeout)
      perform_action :action => 'is_text_present', :arguments => {:text => text, :type => 'TextView'}, :retry_until => timeout
    end

    def has_button?(button_text, timeout = Honeydew.config.timeout)
      perform_action(:action => 'is_button_present', :arguments => {:text => button_text}, :retry_until => timeout)
    end

    def has_child_count?(parent_element_description, child_element_description, child_count, timeout = Honeydew.config.timeout)
      perform_action(:action => 'is_child_count_equal_to', :arguments => {:parent_description => parent_element_description, :child_description => child_element_description, :child_count => child_count}, :retry_until => timeout)
    end

    def has_element_with_nested_text?(parent_description, child_text, timeout = Honeydew.config.timeout)
      perform_action(:action => 'is_element_with_nested_text_present', :arguments => {:parent_description => parent_description, :child_text => child_text}, :retry_until => timeout)
    end

    def has_app_installed?(package_name)
      adb('shell pm list packages').include?(package_name)
    end

    def is_option_in_setting_enabled?(item_name, option_names)
      perform_action :action => 'is_option_in_settings_menu_enabled', :arguments => {:menuName => item_name, :optionNames => option_names}
    end

    def is_option_in_setting_disabled?(item_name, option_names)
      perform_action :action => 'is_option_in_settings_menu_disabled', :arguments => {:menuName => item_name, :optionNames => option_names}
    end

    def has_settings_menu_item?(item_name, timeout = 10)
      perform_action(:action => 'has_settings_menu_item', :arguments => {:menuName => item_name}, :retry_until => timeout)
    end
  end
end