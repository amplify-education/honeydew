require 'spec_helper'

describe Honeydew::DeviceMatchers do
  let(:device) do
    Class.new do
      include Honeydew::DeviceMatchers
      def perform_assertion; end
    end.new
  end

  describe '#has_textview_text' do
    let(:text) { 'some text' }

    it 'should perform action for is_text_present' do
      device.should_receive(:perform_assertion)
        .with(:is_text_present,
              hash_including(text: text, type: 'TextView'),
              timeout: Honeydew.config.timeout)

      device.has_textview_text? text
    end
  end

  describe '#has_textview_with_text_and_description' do
    let(:text) { 'some text' }
    let(:description) { 'some description' }

    it 'performs the is_text_present action' do
      device.should_receive(:perform_assertion)
        .with(:is_text_present,
              hash_including(text: text, type: 'TextView'),
              timeout: Honeydew.config.timeout)

      device.has_textview_with_text_and_description? text, description
    end
  end
end
