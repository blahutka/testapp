require "rubygems"
require 'spork'

Spork.prefork do

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'paperclip/matchers'
  require "shoulda/matchers"
  require "factory_girl"

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  Capybara.default_driver = :rack_test

  RSpec.configure do |config|
    config.include Paperclip::Shoulda::Matchers
    config.include Factory::Syntax::Methods

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = false
    config.use_instantiated_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

  end
end

Spork.each_run do
  FactoryGirl.reload 
end

Spork.after_each_run do

  #DatabaseCleaner.clean
end


