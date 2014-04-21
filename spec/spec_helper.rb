require 'honeydew'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.before do
    Honeydew.configure do |config|
      config.timeout = 2.seconds.to_i
      config.port = 7120
    end
    Honeydew::Device.any_instance.stub(:start_honeydew_server)
    Honeydew::Device.any_instance.stub(ensure_device_ready: true)
  end
end

