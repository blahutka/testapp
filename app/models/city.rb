# -*- encoding : utf-8 -*-
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

  geocoded_by :full_address
  after_validation :geocode, :if => :full_address_changed?

  def full_address
    "#{self.name}, #{self.zip}, Česká republika"
  end

  def full_address_changed?
    return true if self.city_changed? || self.zip_changed? || self.country_changed?
  end

  def to_circle(meters)
    [{:lat => self.latitude, :lng => self.longitude, :radius => meters }]
  end

  def to_mark
    [{:lat => self.latitude, :lng => self.longitude}]
  end

end

City.auto_upgrade!
