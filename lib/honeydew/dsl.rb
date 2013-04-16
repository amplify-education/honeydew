module Honeydew
  module DSL
    def use_device(name, serial)
      eval <<-EOF
        define_singleton_method name.to_sym do |*args, &block|
          Honeydew.using_device('#{serial}', &block)
        end
      EOF
    end

    def use_default_device(name)
      define_singleton_method name.to_sym do |*args, &block|
        Honeydew.using_device(Honeydew.default_device_serial, &block)
      end
    end
  end
end
