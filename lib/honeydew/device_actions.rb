require "honeydew/device_commands"

module Honeydew
  module DeviceActions
    include Honeydew::DeviceCommands

    def click_button button_text
      perform_action :click, :text => button_text, :type => 'Button'
    end

    def click_button_and_wait button_text
      perform_action :click_and_wait_for_new_window, :text => button_text, :type => 'Button'
    end

    def click_text text
      perform_action :click, :text => text, :type => 'TextView'
    end

    def click_text_and_wait text
      perform_action :click_and_wait_for_new_window, :text => text, :type => 'TextView'
    end

    def click_element element_description
      perform_action :click, :description => element_description
    end

    def click_element_and_wait element_description
      perform_action :click_and_wait_for_new_window, :description => element_description
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
      perform_action :launch_app, :appName => application_name, :attempts => 3
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

    def perform_assertion action, arguments = {}, options = {}
      response = perform_action action, arguments, options
      response['success']
    rescue
    end

    def perform_action action, arguments = {}, options = {}
      timeout = options[:timeout]
      attempts = options[:attempts]

      if timeout
        retry_until_timeout timeout, action, arguments
      elsif attempts
        retry_until_success attempts, action, arguments
      else
        execute_command action, arguments
      end
    end

    private

    def retry_until_success attempts, action, arguments
      completed = false
      response = nil
      tries = 0
      until completed ||  tries >= attempts do
        response = execute_command action, arguments
        completed = response['success']
        return response if completed
        tries += 1
        sleep 1
      end
      raise "Device: #{serial} : All #{attempts} attempts failed while performing #{action}, with arguments: #{arguments}"
    end

    def retry_until_timeout timeout, action, arguments
      completed = false
      response = nil
      Timeout.timeout(timeout.to_i) do
        until completed do
          sleep 1
          response = execute_command action, arguments
          completed = response['success']
        end
      end
      return response
    rescue Timeout::Error
      raise "Device: #{serial} :Timeout while performing #{action}, with arguments: #{arguments}"
    end

    def execute_command action, arguments
      ensure_tablet_ready

      log "Device: #{serial} : executing command #{action} with arguments #{arguments}"

      command = stringify_keys(command: {action: action, arguments: arguments})
      response = RestClient.get device_endpoint, :params => command

      log "Device: #{serial} : responded with: #{response}"

      JSON.parse response
    end

    def stringify_keys arguments
      JSON.parse arguments.to_json
    end

    def log message
      puts message
    end
  end
end
