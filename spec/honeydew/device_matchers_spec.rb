require 'spec_helper'

describe Honeydew::DeviceMatchers do

  class DeviceTest
    include Honeydew::DeviceMatchers
    def perform_action; end
  end

  let (:device) { DeviceTest.new }

  describe "#has_textview_text" do
    let (:text) { "some text" }

    it "should perform action for is_text_present" do
      device.should_receive(:perform_action).with(hash_including({action: "is_text_present"}))

      device.has_textview_text? text
    end

    it "should retry for a default timeout" do
      device.should_receive(:perform_action).with(hash_including({retry_until: Honeydew.config.timeout}))

      device.has_textview_text? text
    end

    it "should pass the arguments for the text view" do
      device.should_receive(:perform_action).with(hash_including({arguments: { text: text, type: 'TextView'}}))

      device.has_textview_text? text
    end

  end

  describe "#has_textview_with_text_and_description" do
    let (:text) { "some text" }
    let (:description) { "some description" }

    it "should perform action for is_text_present" do
      device.should_receive(:perform_action).with(hash_including({action: "is_text_present"}))

      device.has_textview_with_text_and_description? text, description
    end

    it "should retry for a default timeout" do
      device.should_receive(:perform_action).with(hash_including({retry_until: Honeydew.config.timeout}))

      device.has_textview_with_text_and_description? text, description
    end

    it "should pass the arguments for the text view" do
      device.should_receive(:perform_action).with(hash_including({arguments: { text: text, description: description, type: 'TextView'}}))

      device.has_textview_with_text_and_description? text, description
    end

  end
end