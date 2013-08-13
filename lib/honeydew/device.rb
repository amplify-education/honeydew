require 'net/http'

require 'honeydew/device_matchers'
require 'honeydew/device_actions'
require 'honeydew/device_log_formatter'

module Honeydew
  class Device
    include Honeydew::DeviceActions
    include Honeydew::DeviceMatchers
    include Honeydew::DeviceLogFormatter

    ServerTimeoutError = Class.new(Timeout::Error)
    ActionFailedError = Class.new(Timeout::Error)
    FinderTimeout = Class.new(Timeout::Error)

    attr_reader :serial, :port

    def initialize(serial)
      @serial = serial

      unless Honeydew.attached_devices.include?(@serial)
        raise ArgumentError, "No device with serial #{@serial} attached"
      end

      @port = Honeydew.config.obtain_new_port
      start_honeydew_server
    end

    def using_timeout timeout
      old_timeout = Honeydew.config.timeout
      Honeydew.config.timeout = timeout
      yield
    ensure
      Honeydew.config.timeout = old_timeout
    end

    private

    def perform_assertion action, arguments = {}, options = {}
      perform_action action, arguments, options
    rescue ActionFailedError
      false
    end

    def perform_action action, arguments = {}, options = {}
      ensure_device_ready
      arguments[:timeout] = Honeydew.config.timeout.to_s
      debug "performing action #{action} with arguments #{arguments}"
      send_command action, arguments
    end

    def send_command action, arguments
      uri = device_endpoint('/command')

      request = Net::HTTP::Post.new uri.path
      request.set_form_data action: action, arguments: arguments.to_json.to_s

      response = benchmark do
        Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.read_timeout = Honeydew.config.server_timeout
          http.request request
        end
      end

      case response
      when Net::HTTPOK
        true
      when Net::HTTPNoContent
        raise ActionFailedError.new response.body
      else
        raise "honeydew-server failed to process command, response: #{response.body}"
      end
    end

    def benchmark
      result = nil
      realtime = Benchmark.realtime do
        result = yield
      end
      debug "action completed in #{(realtime * 1000).to_i}ms"
      result
    end

    def ensure_device_ready
      @device_ready ||= begin
        wait_for_honeydew_server
        true
      end
    end

    def wait_for_honeydew_server
      info 'waiting for honeydew-server to respond'
      Timeout.timeout(Honeydew.config.server_timeout.to_i, ServerTimeoutError) do
        sleep 0.1 until honeydew_server_alive?
      end
      info 'honeydew-server is alive and awaiting commands'

    rescue ServerTimeoutError
      raise 'timed out waiting for honeydew-server to respond'
    end

    def honeydew_server_alive?
      Net::HTTP.get_response(device_endpoint('/status')).is_a?(Net::HTTPSuccess)
    rescue Errno::ECONNREFUSED, Errno::ECONNRESET, Errno::ETIMEDOUT, Errno::ENETRESET, EOFError
    end
  end
end
