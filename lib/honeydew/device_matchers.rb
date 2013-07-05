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

  end
end
