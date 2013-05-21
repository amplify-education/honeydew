require "honeydew/device_matchers"
require "honeydew/device_actions"

module Honeydew
  class Device
    include Honeydew::DeviceActions
    include Honeydew::DeviceMatchers

    attr_reader :serial, :port

    def initialize(serial)
      if serial.to_s.empty?
        raise ArgumentError, 'HoneyDew: Invalid serial or no device connected'
      end
      @port = Honeydew.config.obtain_new_port
      @serial = serial
      start_uiautomator_server
    end

    def contains_textview_text?(text, timeout = Honeydew.config.timeout)
      response = has_textview_text? text, timeout
      response['success']
    rescue
      false
    end

    def contains_element_with_description?(description, timeout = Honeydew.config.timeout)
      response = has_element_with_description? description, timeout
      response['success']
    rescue
      false
    end

    def contains_button?(text, timeout = Honeydew.config.timeout)
      response = has_button? text, timeout
      response['success']
    rescue
      false
    end

    def is_app_installed?(package_name)
      has_app_installed?(package_name)
    end

    def clear_directory(directory)
      all_files_in_directory_path = [directory.chomp('/'), '/*'].join
      adb "shell rm -r #{all_files_in_directory_path}"
    end
    private

    def ensure_tablet_ready
      @device_ready ||= begin
        wait_for_android_server
        true
      end
    end

    def wait_for_android_server
      log 'Waiting for server to come up'
      retriable :on => [RestClient::ServerBrokeConnection, Errno::ECONNRESET, Errno::ECONNREFUSED], :interval => 0.3, :tries => 30 do
        RestClient.head device_endpoint
      end
    end

    def retriable(options, &block)
      tries = options[:tries]
      yield
    rescue *[*options[:on]]
      tries -= 1
      if tries > 0
        sleep options[:interval]
        retry
      else
        raise
      end
    end

  end
end
