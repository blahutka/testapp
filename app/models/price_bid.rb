# -*- encoding : utf-8 -*-
class PriceBid < ActiveRecord::Base
  field :account_profile, :type => :references
  field :skill_invitation, :type => :references

  belongs_to :account_profile
  belongs_to :skill_invitation
end
