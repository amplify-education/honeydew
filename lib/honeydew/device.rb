class Device
  attr_reader :serial
  def initialize()
    connected_device_serial.tap do |serial|
      if serial.to_s.empty?
        log "No devices connected"
        exit(1)
      end
      @serial = serial
    end
  end

  def connected_device_serial
    `adb devices | sed -n 2p | awk '{ print $1 }'`.strip
  end

  def start_uiautomator_server
    log "Starting server in the device #{serial}"
    android_server_path = File.absolute_path(File.join(File.dirname(__FILE__), "../../android-server"))
    Thread.new do
      system "cd #{android_server_path}; mvn clean install"
    end

    log "Forwarding port #{Honeydew.config.port} to device"
    adb "forward tcp:#{Honeydew.config.port} tcp:#{Honeydew.config.port}"

    log "Waiting for server to comeup"
    retriable :on => [RestClient::ServerBrokeConnection, Errno::ECONNRESET, Errno::ECONNREFUSED], :interval => 5, :tries => 12 do
      RestClient.head "http://localhost:#{Honeydew.config.port}/"
    end
  end

  def terminate_uiautomator_server
    log "Terminating server"
    begin
      JSON.parse(RestClient.get("http://localhost:#{Honeydew.config.port}/terminate"))
    rescue Exception
      # Swallow
    end
  end

  def dump_window_hierarchy(local_path)
    path_in_device = perform_action(:action => "dump_window_hierarchy")["description"]
    adb "pull #{path_in_device} #{local_path}"
  end

  def take_screenshot(local_path)
    path_in_device = "/data/local/tmp/honeydew.png"
    adb "shell /system/bin/screencap -p #{path_in_device}"
    adb "pull #{path_in_device} #{local_path}"
  end

  def uninstall_app(package_name)
    adb "uninstall #{package_name}"
  end

  def is_app_installed?(package_name)
    adb "shell pm list packages".include?(package_name)
  end

  def perform_action(options)
    command = options.slice(:action, :arguments)
    timeout = options[:retry_until]

    response = timeout ? retry_until_success(timeout, command) : execute_command(command)
    log_action(command, response)
    raise "Action #{options} failed." unless response["success"]
    response
  end

  private

  def adb(command)
    `adb -s #{serial} #{command}`
  end

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
    JSON.parse(RestClient.get("http://localhost:#{Honeydew.config.port}/", :params => stringify_keys(:command => command)))
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