require "honeydew/version"
require 'retriable'

module Honeydew
  class <<self
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

    private
    def log(message)
      print Time.now
      print " - "
      puts message
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

  def perform_action(command)
    JSON.parse(RestClient.get("http://localhost:9090/", :params => stringify_keys(:command => command))).tap do |response|
      p command.inspect
      p response.inspect
    end
  end

  def stringify_keys(options)
    JSON.parse(options.to_json)
  end

  def retry_until_success(timeout, action, arguments)
    completed = false
    Timeout.timeout(timeout.to_i) do
      until completed do
        completed = perform_action(:action => action, :arguments => arguments)["success"]
        sleep 1
      end
    end
  rescue Timeout::Error
    raise "Timeout while performing #{action}, with arguments: #{arguments}"
  end
end

require 'honeydew/railtie' if defined?(Rails)

