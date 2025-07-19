# frozen_string_literal: true

RSpec.describe LoggerHead do
  let(:error) { StandardError.new("Test error message") }
  let(:logger_head) { LoggerHead.new(error) }
  let(:mock_logger) { double("logger") }

  before do
    allow(logger_head).to receive(:logger).and_return(mock_logger)
  end

  it "has a version number" do
    expect(LoggerHead::VERSION).not_to be nil
  end

  describe "#initialize" do
    it "sets error and provided_context" do
      logger_head = LoggerHead.new(error, provided_context: "testing")
      expect(logger_head.send(:error)).to eq(error)
      expect(logger_head.send(:provided_context)).to eq("testing")
    end

    it "sets provided_context to nil by default" do
      logger_head = LoggerHead.new(error)
      expect(logger_head.send(:provided_context)).to be_nil
    end
  end

  describe "#call" do
    it "calls log_error and log_backtrace" do
      expect(logger_head).to receive(:log_error)
      expect(logger_head).to receive(:log_backtrace)
      logger_head.call
    end
  end

  describe "#log_error" do
    context "without provided_context" do
      it "logs error with boilerplate message" do
        expect(mock_logger).to receive(:error).with("There was an error: Test error message")
        logger_head.log_error
      end
    end

    context "with provided_context" do
      let(:logger_head) { LoggerHead.new(error, provided_context: "during file processing") }

      it "logs error with context" do
        expect(mock_logger).to receive(:error).with("There was an error during file processing: Test error message")
        logger_head.log_error
      end
    end
  end

  describe "#log_backtrace" do
    let(:error_with_backtrace) do
      error = StandardError.new("Test error")
      allow(error).to receive(:backtrace).and_return(["line 1", "line 2", "line 3"])
      error
    end
    let(:logger_head) { LoggerHead.new(error_with_backtrace) }

    it "logs joined backtrace" do
      expect(mock_logger).to receive(:error).with("line 1\nline 2\nline 3")
      logger_head.log_backtrace
    end

    context "when backtrace is nil" do
      let(:error_without_backtrace) do
        error = StandardError.new("Test error")
        allow(error).to receive(:backtrace).and_return(nil)
        error
      end
      let(:logger_head) { LoggerHead.new(error_without_backtrace) }

      it "logs nil" do
        expect(mock_logger).to receive(:error).with(nil)
        logger_head.log_backtrace
      end
    end
  end
end
