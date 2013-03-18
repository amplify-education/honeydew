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

    def log(message)
      print Time.now
      print " - "
      puts message
    end

  end
end

require 'honeydew/railtie' if defined?(Rails)

