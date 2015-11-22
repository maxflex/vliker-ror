ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'capybara/rails'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara::Webkit.configure do |config|
    # Enable debug mode. Prints a log of everything the driver is doing.
    # config.debug = true

    # By default, requests to outside domains (anything besides localhost) will
    # result in a warning. Several methods allow you to change this behavior.

    # Silently return an empty 200 response for any requests to unknown URLs.
    # config.block_unknown_urls

    # Allow pages to make requests to any URL without issuing a warning.
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

end
