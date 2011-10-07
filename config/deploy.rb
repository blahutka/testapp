#===================================================
# LIBRARIES
#===================================================
require(File.join(File.dirname(__FILE__), 'deploy/tasks/sprinkle'))
require(File.join(File.dirname(__FILE__), 'deploy/tasks/capistrano'))

#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
#require "rvm/capistrano"
#set :rvm_ruby_string, "ruby-1.8.7-p302@dumsnadno-test"
#set :rvm_type, :user
#set :use_sudo, false

#===================================================
# CAPISTRANO
#===================================================
set :stages, %w(development production)
set :default_stage, 'development'
require 'capistrano/ext/multistage'
default_run_options[:pty] = true # must be set for the password prompt from git to work
ssh_options[:forward_agent] = true # use local keys instead of the ones on the server

#===================================================
# SERVER
#===================================================
set :sprinkle_path, '../../my-gems/sprinkle-cook'
set :sprinkle_policy, fetch(:sprinkle_policy, 'policies/install-rails.rb')
set :sprinkle_policy_file, File.join(fetch(:sprinkle_path), fetch(:sprinkle_policy))
role :app, 'dumsnadno-dev'

#===================================================
# USER
#===================================================
#set :user, ''
set :user_group, 'deploy'
set :deploy_group, 'testme'

#===================================================
# APPLICATION
#===================================================
set :application, "dumsnadno"
set :repository, "git-user@git-host.com:git/app-repo.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
#===================================================
# TASKS
#===================================================


namespace :server2 do

  task :testme, :roles => :app do

    sprinkle.run(fetch(:sprinkle_policy_file)) do
      policy :users, :roles => :app do
        requires :deploy_user
      end
    end
  end

  desc 'Continuously building server with Sprinkle gem'
  task :build, :roles => :app do
    ubuntu.build
  end

  desc 'Restart server'
  task :restart, :roles => :app do
    ubuntu.restart
  end

  desc 'Start server'
  task :start, :roles => :app do
    ubuntu.start
  end

  desc 'Stop server'
  task :stop, :roles => :app do
    ubuntu.stop
  end


end



#after "deploy:update_code", "deploy:update_shared_symlinks"
#require "bundler/capistrano"
#after "bundle:install", "deploy:migrate"