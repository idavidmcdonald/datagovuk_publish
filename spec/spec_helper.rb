ENV["RAILS_ENV"] = 'test'

require "simplecov"
require "factory_girl_rails"
require "database_cleaner"
require "govuk_sidekiq/testing"
require 'webmock/rspec'

include WebMock::API
WebMock.disable_net_connect!(allow_localhost: true)

Sidekiq::Logging.logger = Rails.logger
Sidekiq::Testing.inline!

SimpleCov.start

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    delete_index
    create_index
  end

  config.order = :random

  config.before(:each) do
    allow_any_instance_of(UrlValidator).to receive(:validPath?).and_return(true)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
