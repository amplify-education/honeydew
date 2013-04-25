module Honeydew
  module DeviceMatchers

    def has_text?(text, timeout = Honeydew.config.timeout)
      perform_action :action => 'is_text_present', :arguments => {:text => text}, :retry_until => timeout
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

    def has_app_installed?(package_name)
      adb('shell pm list packages').include?(package_name)
    end

  end
end
