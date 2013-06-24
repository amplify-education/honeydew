require "honeydew/device_commands"

module Honeydew
  module DeviceActions
    include Honeydew::DeviceCommands

    def click_button(button_text)
      perform_action :action => 'click', :arguments => {:text => button_text, :type => 'Button'}
    end

    def click_button_and_wait(button_text)
      perform_action :action => 'click_and_wait_for_new_window', :arguments => {:text => button_text, :type => 'Button'}
    end

    def click_text(text)
      perform_action :action => 'click', :arguments => {:text => text, :type => 'TextView'}
    end

    def click_text_and_wait(text)
      perform_action :action => 'click_and_wait_for_new_window', :arguments => {:text => text, :type => 'TextView'}
    end

    def click_element(element_description)
      perform_action :action => 'click', :arguments => {:description => element_description}
    end

    def click_element_and_wait(element_description)
      perform_action :action => 'click_and_wait_for_new_window', :arguments => {:description => element_description}
    end

    def fill_in field_description, options = {with: ''}
      perform_action :action => 'set_text', :arguments => {:description => field_description, :text => options[:with]}
    end

    def fill_in_by_label field_label, options = {with: ''}
      perform_action :action => 'set_text_by_label', :arguments => {:label => field_label, :text => options[:with]}
    end

    def fill_in_by_index index, options = {with: ''}
      perform_action :action => 'set_text_by_index', :arguments => {:index => index, :text => options[:with]}
    end

    def launch_home
      perform_action :action => 'launch_home'
    end

    def launch_settings_app(app_name)
      perform_action :action => 'select_from_apps_list', :arguments => {:appName => app_name}
    end

    def launch_application(application_name)
      perform_action :action => 'launch_app', :arguments => {:appName => application_name}, :attempts => 3
    end

    def long_click_element(element_description)
      perform_action :action => 'long_click', :arguments => {:description => element_description}
    end

    def launch_settings_item(item_name)
      perform_action :action => 'select_menu_in_settings', :arguments => {:menuName => item_name}
    end


    def press_back
      perform_action :action => 'press_back'
    end

    def press_enter
      perform_action :action => 'press_enter'
    end

    def unlock
      perform_action :action => 'unlock'
    end

    def wake_up
      perform_action :action => 'wake_up'
    end

    def perform_action(options)
      ensure_tablet_ready

      command = options.slice(:action, :arguments)
      timeout = options[:retry_until]
      attempts = options[:attempts]

      response =
          if timeout
            retry_until_timeout(timeout, command)
          elsif attempts
            retry_until_success(attempts, command)
          else
            execute_command(command)
          end
      log_action(command, response)
      raise "Device: #{serial} :Action #{options} failed." unless response['success']
      response
    end

    private

    def retry_until_success(attempts, command)
      completed = false
      response = nil
      tries = 0
      until completed || (tries >= attempts) do
        response = execute_command(command)
        completed = response['success']
        return response if completed
        tries += 1
        sleep 1
      end
      log_action(command, response)
      raise "Device: #{serial} : All #{attempts} attempts failed while performing #{command[:action]}, with arguments: #{command[:arguments]}"
    end

    def retry_until_timeout(timeout, command)
      completed = false
      response = nil
      Timeout.timeout(timeout.to_i) do
        until completed do
          sleep 1
          response = execute_command(command)
          completed = response['success']
        end
      end
      return response
    rescue Timeout::Error
      log_action(command, response)
      raise "Device: #{serial} :Timeout while performing #{command[:action]}, with arguments: #{command[:arguments]}"
    end

    def execute_command(command)
      response = RestClient.get(device_endpoint, :params => stringify_keys(:command => command))
      JSON.parse(response)
    end

    def log_action(command, response)
      log "Device: #{serial} : executing command: #{command}"
      log "Device: #{serial} : responded with: #{response}"
    end

    def stringify_keys(options)
      JSON.parse(options.to_json)
    end

    def log(message)
      puts message
    end
  end
end
