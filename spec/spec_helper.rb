# -*- encoding : utf-8 -*-
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
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)

    end

    config.after(:suite) do
      
    end

  end
end

Spork.each_run do
  FactoryGirl.reload
  load File.join(Rails.root, 'app/workers/job_invitation_worker.rb')
end

Spork.after_each_run do
  #DatabaseCleaner.clean
end

#REDIS_PID = "#{Rails.root}/tmp/pids/redis-test.pid"
#REDIS_CACHE_PATH = "#{Rails.root}/tmp/cache/"
#
#def start_redis
#
#  redis_options = {
#      "daemonize" => 'yes',
#      "pidfile" => REDIS_PID,
#      "port" => 9736,
#      "timeout" => 300,
#      "save 900" => 1,
#      "save 300" => 1,
#      "save 60" => 10000,
#      "dbfilename" => "dump.rdb",
#      "dir" => REDIS_CACHE_PATH,
#      "loglevel" => "debug",
#      "logfile" => "stdout",
#      "databases" => 16
#  }.map { |k, v| "#{k} #{v}" }.join('\n')
#
#  `echo '#{redis_options}' | redis-server -`
#  puts "started redis: #{redis_options}"
#end
#
#def stop_redis
#  %x{
#      cat #{REDIS_PID} | xargs kill -QUIT
#      rm -f #{REDIS_CACHE_PATH}dump.rdb
#    }
#end


