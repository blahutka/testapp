# -*- encoding : utf-8 -*-
class SkillRequirement < ActiveRecord::Base

  WHEN_FLEXIBLE = [:anytime, :within_weeks, :within_days]

  WHEN_TYPE = ['flexible', 'urgent', 'specific']

  field :public_id, :type => :string
  field :when_type, :type => :string
  field :when_flexible, :type => :string
  field :when_1_date, :type => :date
  field :when_1_hour_from, :type => :time
  field :when_1_hour_till, :type => :time
  field :when_2_date, :type => :date
  field :when_2_hour_from, :type => :time
  field :when_2_hour_till, :type => :time
  field :where, :type => :string
  field :description, :type => :text
  field :skill_request, :type => :references
  field :created_at, :type => :datetime
  field :updated_at, :type => :datetime

  belongs_to :skill_request
  has_many :attachments, :as => :attachable, :class_name => 'SkillRequirementAttachment'

  accepts_nested_attributes_for :attachments

  acts_as_taggable_on :skills

  #validates :skill_list, :presence => true
  validates :when_type, :where, :description, :presence => true
  validates :when_type, :inclusion => {:in => self::WHEN_TYPE}
  #validates :where, :uniqueness => { :case_sensitive => false }
  #validates_uniqueness_of :where

  before_create :generate_public_id

  def generate_public_id
    unless self.skill_request
      self.public_id ||= Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by { rand }.join)
    end
  end

  def when_to_s
    case self.when_type
      when 'flexible' then
        'Jsem flexibilni: ' + self.when_flexible
      when 'urgent' then
        'Co nejdrive'
      when 'specific' then
        self.when_1_date.to_s + "(#{self.when_1_hour_from} - #{self.when_1_hour_till})"
    end
  end
end
SkillRequirement.auto_upgrade!

