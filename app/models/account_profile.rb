# -*- encoding : utf-8 -*-
class AccountProfile < ActiveRecord::Base

  acts_as_taggable_on :skills

  field :name, :type => :string
  field :account, :type => :references

  belongs_to :account
  has_many :invitations, :class_name => 'JobInvitation', :foreign_key => 'to_profile_id'
end

AccountProfile.auto_upgrade!
