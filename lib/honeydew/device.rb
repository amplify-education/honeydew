class Device
  attr_reader :serial

  def initialize(serial)
    puts "Connecting to device: #{serial}"
    if serial.to_s.empty?
      raise ArgumentError, 'HoneyDew: Invalid serial or no device connected'
    end
    @serial = serial
    start_uiautomator_server
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

  def clear_app_data(package_name)
    adb "shell pm clear #{package_name}"
  end

  def reboot
    adb "reboot"
  end

  def is_app_installed?(package_name)
    adb("shell pm list packages").include?(package_name)
  end

  def perform_action(options)
    ensure_tablet_ready

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

  def ensure_tablet_ready
    @device_ready ||= begin
                        wait_for_android_server
                        true
                      end
  end

  def start_uiautomator_server
    log "Starting server on the device with serial #{serial}"
    build_and_start_android_server
    forwarding_port
  end

  def terminate_uiautomator_server
    log "Terminating server"
    JSON.parse(RestClient.get("#{device_endpoint}/terminate"))
  rescue
    # Swallow
  end

  def android_server_path
    File.absolute_path(File.join(File.dirname(__FILE__), "../../android-server"))
  end
  
  # FIXME: Android is the technology, not the purpose - this could have a better name. Automator server perhaps?
  def build_and_start_android_server
    Thread.new do
      # FIXME: Surely this can be done as part of the gem install process, i.e. only start the server here
      system "cd #{android_server_path}; mvn -q clean install -Dmaven.test.skip=true -e"
    end
    at_exit do
      terminate_uiautomator_server
    end
  end

  def wait_for_android_server
    log "Waiting for server to come up"
    retriable :on => [RestClient::ServerBrokeConnection, Errno::ECONNRESET, Errno::ECONNREFUSED], :interval => 5, :tries => 12 do
      RestClient.head device_endpoint
    end
  end

  def forwarding_port
    log "Forwarding port #{Honeydew.config.port} to device"
    adb "forward tcp:#{Honeydew.config.port} tcp:#{Honeydew.config.port}"
  end

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
    response = RestClient.get(device_endpoint, :params => stringify_keys(:command => command))
    JSON.parse(response)
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
