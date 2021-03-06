require "bundler/setup"
require "simplecov"
require "codecov"
require "pry"
require "assert_difference"

SimpleCov.start do
  enable_coverage :branch
end

if ENV["COVERAGE"]
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require "konstrukteur"

RSpec.configure do |config|
  config.include AssertDifference

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
