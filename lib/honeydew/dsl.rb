module Honeydew
  module DSL
    def use_device(name, serial = nil)
      define_singleton_method name.to_sym do |*args, &block|
        Honeydew.using_device(serial, &block)
      end
    end
  end
end
