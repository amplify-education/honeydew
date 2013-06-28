require 'honeydew'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.around :each do |example|
    if example.metadata[:silence_puts]
      silence_stream(STDOUT) { example.run }
    else
      example.run
    end
  end

  config.before do
    Honeydew.configure do |config|
      config.timeout = 2.seconds
      config.port = 7120
    end
    Honeydew::Device.any_instance.stub(:start_uiautomator_server)
    Honeydew::Device.any_instance.stub(ensure_tablet_ready: true)
  end
end

