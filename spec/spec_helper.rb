# frozen_string_literal: true

require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.enable_coverage(:branch)
SimpleCov.minimum_coverage(line: 100, branch: 100)
SimpleCov.start { add_filter 'spec' }

require 'bundler/setup'
require 'meta_struct'
require 'pry'

RSpec.configure do |config|
  Kernel.srand config.seed
  config.disable_monkey_patching!
  config.filter_run_when_matching :focus
  config.order = :random
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  Thread.abort_on_exception = true
end
