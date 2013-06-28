module Honeydew
  module DeviceCommands

    def device_endpoint
      "http://127.0.0.1:#{port}"
    end

    def dump_window_hierarchy(local_path)
      path_in_device = perform_action('dump_window_hierarchy')['description']
      adb "pull #{path_in_device} #{local_path}"
    end

    def take_screenshot(local_path)
      path_in_device = '/data/local/tmp/honeydew.png'
      adb "shell /system/bin/screencap -p #{path_in_device}"
      adb "pull #{path_in_device} #{local_path}"
    end

    def start_uiautomator_server
      forwarding_port
      terminate_uiautomator_server
      log "Device: #{serial} : Starting server on the device"
      start_automation_server
    end

    def terminate_uiautomator_server
      log 'Terminating server'
      RestClient.get("#{device_endpoint}/terminate")
    rescue
      # Swallow
    end

    def automation_test_jar_name
      "android-server-0.0.1-SNAPSHOT.jar"
    end

    def automation_server_jar_path
      File.absolute_path(File.join(File.dirname(__FILE__), "../../android-server/target/#{automation_test_jar_name}"))
    end

    def start_automation_server
      Thread.new do
        adb "push #{automation_server_jar_path} /data/local/tmp"
        adb "shell uiautomator runtest #{automation_test_jar_name} -c com.uiautomator_cucumber.android_server.TestRunner"
        log "Device: #{serial} initiated the start of automation server"
      end
      at_exit do
        terminate_uiautomator_server
      end
    end

    def forwarding_port
      log "Device: #{serial} : Forwarding port #{port} to device"
      adb "forward tcp:#{port} tcp:7120"
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
      adb 'reboot'
    end

    def launch_settings
      adb 'shell am start -n com.android.settings/com.android.settings.Settings'
    end

    def adb(command)
      adb_command = "adb -s #{serial} #{command}"
      log "Device: #{serial} :Executing '#{adb_command}'"
      `#{adb_command}`.tap { raise 'ADB command failed' unless $?.success? }
    end

  end
end
