module Honeydew
  module DeviceLogFormatter
    Logger::Severity.constants.each do |severity|
      severity_sym = severity.to_s.downcase.to_sym
      define_method severity_sym do |message|
        Honeydew.config.logger.send(severity_sym, "Device #{serial}: #{message}")
      end
    end
  end
end
