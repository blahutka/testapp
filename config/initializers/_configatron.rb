require 'configatron'

configatron.aws.access_key = ENV['S3_KEY']
configatron.aws.secret_access_key = ENV['S3_SECRET']

if Rails.env == 'development'

end

if Rails.env == 'test'

end

if Rails.env == 'production'

end