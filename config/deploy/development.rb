# -*- encoding : utf-8 -*-
#===================================================
# DEVELOPMENT STAGE
#===================================================

set :user, 'vagrant'
set :deployer, 'blahutka'
set :group, 'deployer'
set :rails_env, 'development'

#set :sprinkle_policy, 'policies/install-rails.rb'

namespace :ubuntu do

  task :start, :roles => :app do
    vagrant.start if ui.agree('Start server? : ', true) { |q| q.default = 'No' }
  end

  task :stop, :roles => :app do
    vagrant.stop
  end

  task :restart, :roles => :app do
    vagrant.reload
  end


  task :build do
    sprinkle.run(:testing => false, :verbose => true) do
      load_packages :except =>[:deploy_user]



      policy :stack, :roles => :app do
        #requires :ssh
        requires :deployer
      end

      deployment do
        delivery :capistrano do

          recipes 'Capfile'
          recipes 'config/deploy/development.rb'

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


namespace :vagrant do

  desc 'Start Vagrant machine'
  task :start do
    system "bundle exec vagrant up"
  end
  desc 'Halt Vagrant machine'
  task :stop do
    system "bundle exec vagrant halt"
  end
  task :reload do
    system "bundle exec vagrant reload"
  end


end
