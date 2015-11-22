require 'capybara/rspec'
require 'capybara-webkit'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

Capybara.javascript_driver = :webkit
Capybara::Webkit.configure do |config|
  config.allow_unknown_urls

  # Allow a specific domain without issuing a warning.
  # config.allow_url("vk.com")
  config.block_url("vk.com")
  config.block_url("graffitistudio.ru")

  # Timeout if requests take longer than 5 seconds
  config.timeout = 5

  # Don't raise errors when SSL certificates can't be validated
  config.ignore_ssl_errors

  # Don't load images
  config.skip_image_loading
end
