# -*- encoding : utf-8 -*-
class AccountProfile < ActiveRecord::Base
  DEFAULT_RADIUS = 20
  
  acts_as_taggable_on :skills

  field :company_name, :type => :string
  field :street, :type => :string
  field :city, :type => :string
  field :zip, :type => :integer
  field :country, :type => :string
  field :latitude, :type => :float
  field :longitude, :type => :float
  field :radius, :type => :integer
  field :account, :type => :references
  field :occupation, :typ => :references
  field :phone_number, :type => :string
  field :mobile_number, :type => :string
  field :web_site, :type => :string
  field :work_hours, :type => :string
  serialize :work_hours, Hash
  field :description, :type => :text
  serialize :description, Hash

  geocoded_by :full_address
  after_validation :geocode, :if => :full_address_changed?

  acts_as_gmappable :process_geocoding => false

  belongs_to :account
  has_many :invitations, :class_name => 'JobInvitation', :foreign_key => 'to_profile_id'

  has_many :attachments, :as => :attachable, :class_name => 'AccountProfileAttachment'
  accepts_nested_attributes_for :attachments, :allow_destroy => true

  before_save :check_radius

  def full_address
    "#{self.city}, #{self.zip}, #{self.country}" if (self.city.present? && self.zip.present?)
  end

  def full_address_changed?
    return true if self.city_changed? || self.zip_changed? || self.country_changed?
  end

 def check_radius
   self.radius ||= DEFAULT_RADIUS 
 end

  def self.serialized_attr_accessor(*args)
    args.each do |method_name|
      eval "
        def #{method_name}
          (self.description || {})[:#{method_name}]
        end
        def #{method_name}=(value)
          self.description ||= {}
          self.description[:#{method_name}] = value
        end
      "
    end
  end

  serialized_attr_accessor :experience, :what, :why
end

AccountProfile.auto_upgrade!
