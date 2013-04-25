require 'spec_helper'

describe Honeydew::Device, :silence_puts do
  let(:response) { "{ \"success\": true }" }
  let(:command)  { {"action" => '', "arguments" => {}} }
  let(:serial)   { "ABC123DEF" }

  before do
    @device =  Honeydew::Device.new serial
    @device_end_point = "http://127.0.0.1:#{@device.port}"
    RestClient.stub(:get).with(@device_end_point, params: { "command" => command}).and_return(response)
  end

  describe "contains_textview_text?" do
    let(:text)     { "Ok" }
    let(:command)  { {"action" => 'is_text_present', "arguments" => {"text" => text, "type" => 'TextView'}} }

    it "should make the call with command is_text_present" do
      RestClient.should_receive(:get).with(@device_end_point, params: { "command" => command}).and_return(response)
      @device.contains_textview_text?(text)
    end

    context "on successful response" do
      let(:response) { "{ \"success\": true }" }

      it "should return true" do
        @device.contains_textview_text?(text).should be_true
      end
    end

    context "on failure response" do
      let(:response) { "{ \"success\": false }" }

      it "should return false" do
        @device.contains_textview_text?(text).should be_false
      end
    end
  end

  describe "contains_button?" do
    let(:text)     { "Ok" }
    let(:command)  { {"action" => 'is_button_present', "arguments" => {"text" => text}} }

    it "should make the call with command is_button_present" do
      RestClient.should_receive(:get).with(@device_end_point, params: { "command" => command}).and_return(response)
      @device.contains_button?(text)
    end

    context "on successful response" do
      let(:response) { "{ \"success\": true }" }

      it "should return true" do
        @device.contains_button?(text).should be_true
      end
    end

    context "on failure response" do
      let(:response) { "{ \"success\": false }" }

      it "should return false" do
        @device.contains_button?(text).should be_false
      end
    end
  end

end
