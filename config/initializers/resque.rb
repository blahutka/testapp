# -*- encoding : utf-8 -*-
ENV["REDISTOGO_URL"] ||= "redis://username:password@host:1234/"

uri = URI.parse(ENV["REDISTOGO_URL"])
# Skip to add worker to queue for test environment
Resque.inline = (Rails.env == "test" || 'development')
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  password == "petr"
end
