require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
  #ENV['VVERBOSE'] = '1'
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end