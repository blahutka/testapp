source 'http://rubygems.org'

#============================================================================
# DEFAULT
#============================================================================
gem 'rails'
gem 'json'
gem 'jquery-rails'
gem 'jquery-ui-themes'
gem 'pg'

# RAILS ADMIN
gem 'activeadmin'

#gem 'devise' # Login
gem 'sorcery' # Login, twitter, FB..
gem 'koala'
gem "cancan" # Roles
gem 'foreman' # services start
#gem 'thin' # ruby server
gem 'configatron' # app config tool


gem 'i18n_routing' # localized routes
gem 'inherited_resources'
gem 'cells' # widgets
gem 'erector', :git => 'git://github.com/pivotal/erector.git'
gem 'mini_record' # auto migrations
gem 'will_paginate'
#gem 'geokit' # plus install git://github.com/bhedana/google_maps.git
gem "geocoder"
gem 'gmaps4rails' # Google maps
#gem 'aws-s3'
#gem "paperclip", "~> 2.4" #file upload
gem "friendly_id", "~> 4.0.0.beta8" #permanent url
gem 'simple_state_machine'
gem 'acts-as-taggable-on', '~>2.1.0'
gem 'client_side_validations', '~> 3.0.0'
gem 'chosen_rails', :git => 'git://github.com/bseanvt/chosen_rails.git'
gem 'iconic' #icons svg files
gem 'fog'
gem 'rmagick'
gem 'carrierwave' # file upload
gem 'nested_form', :git => 'git://github.com/jweslley/nested_form.git' # jquery remove, add links
gem "vanity-rails3", "~> 1.7.4" # A/B testing 

# Background job
gem 'resque', :require => "resque/server"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'compass', :branch => 'master', :git => 'git://github.com/chriseppstein/compass.git'
  gem 'compass-validator'
  gem 'sassy_noise' # Noise backgrounds
  gem 'less-rails-bootstrap', '~> 1.4.0'
end

#============================================================================
# PRODUCTION
#============================================================================

#============================================================================
# DEVELOPMENT
#============================================================================
group :development, :test do
  gem 'pry' # debug rails run => pry -r ./config/environment
  gem 'database_cleaner'

end
group :development do
  #gem "hooves", "~> 0.3" #unicorn start handler => rails s unicorn
  gem "factory_girl_rails", :require => false
  gem 'seed_dump', :path => '/home/blahutka/netbeans_projects/my-gems/seed_dump'
  gem 'guard'
  gem "rb-inotify"
  gem 'libnotify'
  gem 'launchy'
  gem 'guard-rails'
  gem 'guard-livereload'
  gem 'rails3-generators'
  gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git', :require => 'rails_development_boost'
  gem 'magic_encoding' # command to utf-8 encoding files for ruby 1.9
  gem 'bson_ext'
end

#============================================================================
# TEST
#============================================================================
group :cucumber do
  gem 'cucumber-rails'
  gem 'factory_girl', :require => false
  gem "factory_girl_rails", :require => false
  gem 'pickle'
  gem "capybara"
  gem "spork", "> 0.9.0.rc"
end
group :test do
  gem 'factory_girl', :require => false
  gem "factory_girl_rails", :require => false
  gem "rspec-rails"
  gem 'shoulda-matchers'
  gem "capybara"
  gem "guard-rspec"
  gem "guard-spork"
  gem "rb-inotify"
  gem 'libnotify'
  gem 'launchy'
  gem 'yajl-ruby'
  # run faster tests
  gem "spork", "> 0.9.0.rc"
  # Ubuntu apt-get install libqt4-dev
  # javascript headless test
  gem 'capybara-webkit'
end

