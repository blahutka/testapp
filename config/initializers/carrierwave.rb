CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => configatron.aws.access_key,       # required
    :aws_secret_access_key  => configatron.aws.secret_access_key,       # required
    :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'dums-nadno.cz'                     # required
  config.fog_host       = 'http://dums-nadno.cz.s3.amazonaws.com'            # optional, defaults to nil
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end