# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-07-19

### Added
- Initial release of LoggerHead gem
- Simple structured error logging utility with context support
- Rails logger integration with fallback to standard Ruby Logger
- Error message logging with contextual information
- Backtrace logging for debugging
- Clean API for error handling

### Features
- Automatic detection of Rails environment
- Contextual error messages with customizable prefixes
- Full backtrace logging for debugging
- Simple initialization with error and optional context
- Lightweight with no external dependencies (except Logger for non-Rails apps)

### Usage
```ruby
# Basic usage
begin
  # some code that might raise an error
rescue => e
  LoggerHead.new(e, provided_context: "Processing user data").call
end

# Without context
LoggerHead.new(error).call
```