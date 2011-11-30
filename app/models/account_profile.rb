# -*- encoding : utf-8 -*-
class AccountProfile < ActiveRecord::Base

  acts_as_taggable_on :skills

  field :name, :type => :string
  field :city, :type => :string
  field :zip, :type => :integer
  field :country, :type => :string
  field :latitude, :type => :float
  field :longitude, :type => :float
  field :radius, :type => :integer
  field :account, :type => :references

  geocoded_by :full_address
  after_validation :geocode, :if => :full_address_changed?

  acts_as_gmappable :process_geocoding => false

  belongs_to :account
  has_many :invitations, :class_name => 'JobInvitation', :foreign_key => 'to_profile_id'

  def full_address
    "#{self.city}, #{self.zip}, #{self.country}"
  end

  def full_address_changed?
    return true if self.city_changed? || self.zip_changed? || self.country_changed?
  end

end

AccountProfile.auto_upgrade!
