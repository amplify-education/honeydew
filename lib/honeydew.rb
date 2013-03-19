require "honeydew/version"
require 'retriable'

module Honeydew
  extend self

  def start_uiautomator_server
    log "Starting server in the device"
    gem_path = Gem.loaded_specs['honeydew'].full_gem_path
    Thread.new do
      system "cd #{gem_path}/android-server; mvn clean install"
    end

    log "Forwarding port 9090 to device"
    system "adb forward tcp:9090 tcp:9090"

    log "Waiting for server to comeup"
    ::Retriable.retriable :on => [RestClient::ServerBrokeConnection, Errno::ECONNRESET, Errno::ECONNREFUSED], :interval => 5, :tries => 12 do
      RestClient.head "http://localhost:9090/"
    end
  end

  def terminate_uiautomator_server
    log "Terminating server"
    begin
      JSON.parse(RestClient.get("http://localhost:9090/terminate"))
    rescue Exception
      # Swallow
    end
  end

  def dump_window_hierarchy(local_path)
    path_in_device = perform_action(:action => "dump_window_hierarchy")["description"]
    `adb pull #{path_in_device} #{local_path}`
  end

  def take_screenshot(local_path)
    path_in_device = "/data/local/tmp/honeydew.png"
    `adb shell /system/bin/screencap -p #{path_in_device}`
    `adb pull #{path_in_device} #{local_path}`
  end

  def perform_action(options)
    command = options.slice(:action, :arguments)
    timeout = options[:retry_until]

    response = timeout ? retry_until_success(timeout, command) : execute_command(command)
    log_action(command, response)
    response
  end

  private
  def retry_until_success(timeout, command)
    completed = false
    response = nil
    Timeout.timeout(timeout.to_i) do
      until completed do
        sleep 1
        response = execute_command(command)
        completed = response["success"]
      end
    end
    return response
  rescue Timeout::Error
    log_action(command, response)
    raise "Timeout while performing #{command[:action]}, with arguments: #{command[:arguments]}"
  end

  def execute_command(command)
    JSON.parse(RestClient.get("http://localhost:9090/", :params => stringify_keys(:command => command)))
  end

  def log_action(command, response)
    log command
    log response
  end

  def stringify_keys(options)
    JSON.parse(options.to_json)
  end

  def log(message)
    p message
  end
end

require 'honeydew/railtie' if defined?(Rails)

