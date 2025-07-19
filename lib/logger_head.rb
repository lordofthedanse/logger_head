# frozen_string_literal: true

require_relative "logger_head/version"

class LoggerHead
  VERSION = LoggerHeadGem::VERSION

  def initialize(error, provided_context: nil)
    @error = error
    @provided_context = provided_context
  end

  def call
    log_error
    log_backtrace
  end

  def log_error
    boilerplate = "There was an error"
    error_context = [boilerplate, provided_context].compact.join(" ")
    logger.error "#{error_context}: #{error.message}"
  end

  def log_backtrace
    logger.error error.backtrace&.join("\n")
  end

  private

  attr_reader :error, :provided_context

  def logger
    @logger ||= if defined?(Rails)
                  Rails.logger
                else
                  require 'logger'
                  Logger.new($stdout)
                end
  end
end
