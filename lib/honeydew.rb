require "honeydew/version"
require "honeydew/device"

module Honeydew
  class Configuration
    attr_accessor :port, :started

    def initialize
      @port = 7120
    end
  end

  class <<self
    attr_accessor :config, :default_device

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

    def start_uiautomator_server
      default_device.start_uiautomator_server
    end

    def terminate_uiautomator_server
      default_device.terminate_uiautomator_server
    end
  end
end

require 'honeydew/railtie' if defined?(Rails)

