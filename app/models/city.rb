class City < ActiveRecord::Base
#  id`, `name`, `district`, `country_id`, `created_at`, `updated_at`, `zip`, `latitude`, `longtitude`, `region_id`
  field :name, :type => :string
  field :district, :type => :string
  field :zip, :type => :integer
  field :latitude, :type => :float
  field :longitude, :type => :float
  field :region_id, :type => :integer
  field :country_id, :type => :integer
  field :created_at, :type => :datetime
  field :updated_at, :type => :datetime

end

City.auto_upgrade!
