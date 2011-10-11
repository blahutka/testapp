# -*- encoding : utf-8 -*-
Capistrano::Configuration.instance(true).load() do
  namespace :sprinkle2 do

    def shell(package_setup_path, verbose = '-v')
      servers, setup = show_stack_setup(package_setup_path)
      puts setup
      if ui.agree("Start build server on: '#{servers}'? ", true) { |q| q.default = 'No' }
        system "bundle exec sprinkle -c -s #{package_setup_path} #{verbose}"
      end
    end

    def run(sprinkle_policy_file, &block)
      require "sprinkle"
      require 'sourcify'
      servers, msg = show_stack_setup(sprinkle_policy_file)
      puts msg
      Sprinkle::OPTIONS[:verbose] = true
      Sprinkle::OPTIONS[:testing] = true
      script = File.read(sprinkle_policy_file)
      script << block.to_source(:strip_enclosure => true) if block_given?
      Sprinkle::Script.sprinkle(script, sprinkle_policy_file) if ui.agree("Start build? #{servers}: ", true) { |q| q.default = 'No' }

    end


    def run3
      require "sprinkle"
      require 'sprinkle_packages'
      Sprinkle::OPTIONS[:cloud]
      Sprinkle::OPTIONS[:verbose] = true
      Sprinkle::OPTIONS[:testing] = false
      spr = Sprinkle::Script.new

      spr.instance_eval('SprinklePackages::Import.new')

      spr.package :mysql do
        apt 'vim'
        verify { has_executable 'vim' }
      end

      spr.policy :stack, :roles => :app do
        requires :mysql
        requires :build_essential
        requires :nginx
      end

      spr.deployment do
        delivery :capistrano do
          set :user, :vagrant
          role :app, 'dumsnadno-dev'
        end
        source do
          prefix '/usr/local'
          archives '/usr/local/sources'
          builds '/usr/local/build'
        end
      end


      spr.sprinkle
    end


    def show_stack_setup(package_setup_path)
      str = []
      str << '************************************************************************'
      str << ' Stack Setup'
      str << ' START >>'
      str << ''
      str << %x`bundle exec sprinkle -t -c -s #{package_setup_path}`
      str << ''
      str << '<< END'
      str << '************************************************************************'

      [find_servers_for_task(current_task), str.join("\n")]
    end
  end


end
