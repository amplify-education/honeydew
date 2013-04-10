class Device
  attr_reader :serial

  def initialize
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
      system "cd #{android_server_path}; mvn -q clean install -Dmaven.test.skip=true"
    end

    log "Forwarding port #{Honeydew.config.port} to device"
    adb "forward tcp:#{Honeydew.config.port} tcp:#{Honeydew.config.port}"

    log "Waiting for server to comeup"
    retriable :on => [RestClient::ServerBrokeConnection, Errno::ECONNRESET, Errno::ECONNREFUSED], :interval => 5, :tries => 12 do
      RestClient.head device_endpoint
    end
  end

  def terminate_uiautomator_server
    log "Terminating server"
    JSON.parse(RestClient.get("#{device_endpoint}/terminate"))
  rescue Exception
    # Swallow
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

  def install_app(apk_location)
    adb "install #{apk_location}"
  end

  def reboot
    adb "reboot"
  end

  def is_app_installed?(package_name)
    adb("shell pm list packages").include?(package_name)
  end

  def perform_action(options)
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
    raise "Action #{options} failed." unless response["success"]
    response
  end

  private

  def adb(command)
    adb_command = "adb -s #{serial} #{command}"
    log "Executing '#{adb_command}'"
    `#{adb_command}`
  end

  def device_endpoint
    "http://localhost:#{Honeydew.config.port}"
  end

  def retry_until_success(attempts, command)
    completed = false
    response = nil
    tries = 0
    until completed || (tries >= attempts) do
      response = execute_command(command)
      completed = response["success"]
      return response if completed
      tries += 1
      sleep 1
    end

    log_action(command, response)
    raise "All #{attempts} attempts failed while performing #{command[:action]}, with arguments: #{command[:arguments]}"
  end

  def retry_until_timeout(timeout, command)
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
    JSON.parse(RestClient.get(device_endpoint, :params => stringify_keys(:command => command)))
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