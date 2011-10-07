source 'http://rubygems.org'

#============================================================================
# DEFAULT
#============================================================================
gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-1-stable'
gem 'json'
gem 'jquery-rails'
gem 'pg'

# RAILS ADMIN
gem 'activeadmin'

gem 'devise' # Login
gem "cancan" # Roles
gem 'foreman' # services start
gem 'thin' # ruby server


gem 'i18n_routing' # localized routes
gem 'cells' # widgets
gem 'mini_record' # auto migrations
gem 'will_paginate'
gem 'magic_encoding' # utf-8 encoding ruby 1.9
gem 'geokit' # plus install git://github.com/bhedana/google_maps.git
gem 'aws-s3'
gem "paperclip", "~> 2.4" #file upload
gem "friendly_id", "~> 4.0.0.beta8" #permanent url
gem 'simple_state_machine'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'compass', :branch => 'master', :git => 'git://github.com/chriseppstein/compass.git'
  gem 'compass-validator'
  gem 'sassy_noise' # Noise backgrounds
end

#============================================================================
# PRODUCTION
#============================================================================
group :production do
  gem 'haml'
end

#============================================================================
# DEVELOPMENT
#============================================================================
group :development, :test do
  gem 'mysql2'
  gem 'pry' # debug rails run => pry -r ./config/environment
  gem 'database_cleaner'
end
group :development do
  #gem "hooves", "~> 0.3" #unicorn start handler => rails s unicorn
  gem 'seed_dump', :path => '/home/blahutka/netbeans_projects/my-gems/seed_dump'
  gem 'guard'
  gem "rb-inotify"
  gem 'libnotify'
  gem 'launchy'
  gem 'guard-rails'
  gem 'guard-livereload'
  gem 'rails3-generators'
  gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git', :require => 'rails_development_boost'
end

#============================================================================
# TEST
#============================================================================
group :test do
  gem "rspec-rails"
  gem 'shoulda-matchers'
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "guard-spork"
  gem "rb-inotify"
  gem 'libnotify'
  gem 'launchy'
  gem 'yajl-ruby'
  gem "spork", "> 0.9.0.rc" # run faster tests
end

