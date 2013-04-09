require "honeydew/version"
require "honeydew/device"

module Honeydew
  class Configuration
    attr_accessor :port

    def initialize
      @port = 7120
    end
  end

  class <<self
    attr_accessor :config, :default_device, :started

    def config
      return @config if @config
      configure
      @config
    end

    def configure
      @config ||= Configuration.new
      yield(@config) if block_given?
    end

    def default_device
      @default_device ||= Device.new
    end

    def start_uiautomator_server(started_status=@started)
      return if started_status
      default_device.start_uiautomator_server
      @started = true
    end

    def terminate_uiautomator_server
      default_device.terminate_uiautomator_server
    end

    at_exit do
      Honeydew.terminate_uiautomator_server if Honeydew.started
    end
  end
end