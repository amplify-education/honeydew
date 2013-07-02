require "honeydew/device_commands"

module Honeydew
  module DeviceActions
    include Honeydew::DeviceCommands

    def click_button button_text
      perform_action :click, :text => button_text, :type => 'Button'
    end

    def click_button_and_wait button_text
      perform_assertion :click_and_wait_for_new_window, :text => button_text, :type => 'Button'
    end

    def click_text text
      perform_action :click, :text => text, :type => 'TextView'
    end

    def click_text_and_wait text
      perform_assertion :click_and_wait_for_new_window, :text => text, :type => 'TextView'
    end

    def click_element element_description
      perform_action :click, :description => element_description
    end

    def click_element_and_wait element_description
      perform_assertion :click_and_wait_for_new_window, :description => element_description
    end

    def fill_in field_description, options = {with: ''}
      perform_action :set_text, :description => field_description, :text => options[:with]
    end

    def fill_in_by_label field_label, options = {with: ''}
      perform_action :set_text_by_label, :label => field_label, :text => options[:with]
    end

    def fill_in_by_index index, options = {with: ''}
      perform_action :set_text_by_index, :index => index, :text => options[:with]
    end

    def launch_home
      perform_action :launch_home
    end

    def launch_settings_app app_name
      perform_action :select_from_apps_list, :appName => app_name
    end

    def launch_application application_name
      perform_action :launch_app, :appName => application_name
    end

    def long_click_element element_description
      perform_action :long_click, :description => element_description
    end

    def launch_settings_item item_name
      perform_action :select_menu_in_settings, :menuName => item_name
    end

    def press_back
      perform_action :press_back
    end

    def press_enter
      perform_action :press_enter
    end

    def unlock
      perform_action :unlock
    end

    def wake_up
      perform_action :wake_up
    end
  end
end
