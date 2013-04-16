require 'bundler'
require 'bundler/setup'
require 'restclient'
require 'active_support/core_ext'

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
    attr_accessor :config

    def config
      return @config if @config
      configure
      @config
    end

    def configure
      @config ||= Configuration.new
      yield(@config) if block_given?
    end

    def device_serial_list
      `adb devices`.split("\n").drop(1).collect {|line| line.split[0].chomp}
    end

    def default_device_serial
      device_serial_list.first
    end

    def default_device
      @default_device ||= device[default_device_serial]
    end

    def current_device
      @current_device ||= default_device
    end

    def using_device(serial, &block)
      original_device = current_device
      use_device(serial).tap do |device|
        device.instance_eval(&block) if block_given?
      end
    ensure
      @current_device = original_device
    end

    def use_device(serial)
      @current_device = device[serial]
    end

    def device
      @devices ||= Hash.new do |hash, serial|
        hash[serial] = Device.new(serial)
      end
    end
  end
end
