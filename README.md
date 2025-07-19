# LoggerHead

A simple structured error logging utility with context support for Ruby applications. LoggerHead provides structured error logging with contextual information for better debugging and error tracking.

Originally extracted from DetectionTek patterns, LoggerHead offers consistent error logging that works in both Rails and non-Rails environments.

## Features

- **Structured Error Logging**: Logs errors with contextual information
- **Automatic Backtrace Logging**: Captures and logs full error backtraces
- **Context-Aware**: Allows adding descriptive context to errors for better debugging
- **Environment Agnostic**: Works with Rails.logger or standard Ruby Logger
- **Zero Dependencies**: Pure Ruby with no external dependencies
- **Simple API**: Easy to integrate into existing codebases

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logger_head'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install logger_head
```

## Usage

### Basic Usage

```ruby
require 'logger_head'

begin
  # Some operation that might fail
  raise StandardError, "Something went wrong"
rescue => error
  # Log with context
  LoggerHead.new(error, provided_context: "during user creation").call
end
```

### With Custom Context

```ruby
# Log error with specific context
error = StandardError.new("Database connection failed")
LoggerHead.new(error, provided_context: "in payment processing").call

# Output:
# ERROR -- : There was an error in payment processing: Database connection failed
# ERROR -- : /path/to/file:123:in `method_name'
#           /path/to/file:456:in `other_method'
#           ...
```

### In Rails Applications

LoggerHead automatically uses `Rails.logger` when available:

```ruby
class UsersController < ApplicationController
  def create
    User.create!(user_params)
  rescue => error
    LoggerHead.new(error, provided_context: "creating user #{params[:name]}").call
    render json: { error: "User creation failed" }, status: 422
  end
end
```

### In Service Objects

```ruby
class CreateUserService
  def call
    # ... service logic
  rescue => error
    LoggerHead.new(error, provided_context: "in #{self.class.name}").call
    # Handle error appropriately
  end
end
```

### Integration with Hmibo

LoggerHead is integrated into the [Hmibo gem](https://github.com/wendcare/hmibo) for service object patterns:

```ruby
class MyService < Hmibo::Base
  def perform
    # Any errors are automatically logged with LoggerHead
    raise StandardError, "Something went wrong"
  end
end

# Automatically logs: "There was an error in MyService execution: Something went wrong"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## API Reference

### LoggerHead.new(error, provided_context: nil)

Creates a new LoggerHead instance.

**Parameters:**
- `error` (Exception): The error/exception to log
- `provided_context` (String, optional): Additional context information

**Returns:** LoggerHead instance

### #call

Executes the logging operation, writing both the error message and backtrace to the logger.

**Returns:** nil

## Testing

The gem includes a comprehensive test suite. Run tests with:

```bash
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/detectiontek/logger_head.

1. Fork the repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write tests for your changes
4. Ensure all tests pass (`bundle exec rspec`)
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
