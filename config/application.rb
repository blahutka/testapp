# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "rails/all"

# require "rails/test_unit/railtie"

# If you have a Gemfile, require the default gems, the ones in the
# current environment and also include :assets gems if in development
# or test environments.
Bundler.require *Rails.groups(:assets) if defined?(Bundler)

module Dumsnadno
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec, :views => false, :fixture => false
      #g.test_framework :test_unit, :fixture => true
      g.stylesheets false
      g.javascript false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      #g.form_builder :simple_form
      #g.template_engine :haml
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/workers #{config.root}/app/uploaders)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :cs

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    #MAIL DELIVERY
    config.action_mailer.default_url_options = {:host => "dumsnadno.cz"}
    config.action_mailer.perform_deliveries = false
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => 587,
        :domain => 'dumsnadno.cz',
        :user_name => ENV['GMAIL_USER'],
        :password => ENV['GMAIL_PASS'],
        :authentication => 'plain',
        :enable_starttls_auto => true}
  end
end
