# frozen_string_literal: true

require_relative "lib/logger_head/version"

Gem::Specification.new do |spec|
  spec.name = "logger_head"
  spec.version = LoggerHeadGem::VERSION
  spec.authors = ["Dan Brown"]
  spec.email = ["dbrown@occameducation.com"]

  spec.summary = "A simple structured error logging utility with context support"
  spec.description = "LoggerHead provides structured error logging with contextual information for better debugging and error tracking in Ruby applications."
  spec.homepage = "https://github.com/detectiontek/logger_head"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["source_code_uri"] = "https://github.com/detectiontek/logger_head"
  spec.metadata["changelog_uri"] = "https://github.com/detectiontek/logger_head/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
