# -*- encoding : utf-8 -*-
set :sprinkle_stack, 'install.rb'
set :rails_env, :production

set :user, 'vagrant'
#set :password, Capistrano::CLI.ui.ask("Password for user '#{fetch(:user)}': ") { |q| q.echo = false }

#ssh_options[:config] = false
server 'dumsnadno-dev', :app, :web, :primary => true


namespace :ubuntu do


  task :build do
    sprinkle.run(:testing => true) do
      load_packages

      policy :stack, :roles => :app do
        requires :mysql_restart
      end

      deployment do

        delivery :capistrano do
          recipes 'Capfile'
          recipes 'config/deploy/production.rb'
        end
        source do
          prefix '/usr/local'
          archives '/usr/local/sources'
          builds '/usr/local/build'
        end

      end
    end

  end

end
