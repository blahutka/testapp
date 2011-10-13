# -*- encoding : utf-8 -*-
class JobInvitation < ActiveRecord::Base

  field :to_profile, :type => :references
  field :from_request, :type => :references
  field :created_at, :type => :datetime

  belongs_to :to, :class_name => 'AccountProfile'
  belongs_to :from, :class_name => 'SkillRequest', :foreign_key => 'from_request_id'

  has_many :price_bids


  #validate :check_ownership

  def check_ownership
    if self.to.account === self.from.account
      errors[:base] << 'Wrong relationship'
    end
  end


end

JobInvitation.auto_upgrade!
