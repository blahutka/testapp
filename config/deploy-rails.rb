# -*- encoding : utf-8 -*-
#!/usr/bin/env sprinkle -s

#  http://maxim.github.com/sprinkle-cheatsheet/

# Dir.glob(File.join(File.dirname(__FILE__), 'packages/*.rb')).each { |f| require f }
#require "packages/sprinkle/user"
require "packages/spec"
require 'packages/essential'
require 'packages/rails'
require 'packages/database'
require 'packages/server'
require 'packages/search'
require 'packages/scm'



#policy :rails, :roles => :app do
#  #requires :rails, :version => '2.3.3'
#  #requires :appserver
#  #requires :database
#  #requires :webserver
#  #requires :search
#  #requires :scm
#end

policy :dumsnadno_app, :roles => :dumsnadno_server do
  requires :sphinx
end


# Deployment
#
#  Defines script wide settings such as a delivery mechanism for executing commands on the target
#  system (eg. capistrano), and installer defaults (eg. build locations, etc):
#
#   Configures spinkle to use capistrano for delivery of commands to the remote machines (via
#   the named 'deploy' recipe). Also configures 'source' installer defaults to put package gear
#   in /usr/local

deployment do

  # mechanism for deployment
  delivery :capistrano do
    recipes 'deploy'
  end

  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end

end

# End of script, given the above information, Spinkle will apply the defined policy on all roles using the
# deployment settings specified.
