# -*- encoding : utf-8 -*-
class JobInvitation < ActiveRecord::Base
  
  field :to, :type => :references
  field :from, :type => :references

  belongs_to :to, :class_name => 'AccountProfile'
  belongs_to :from, :class_name => 'SkillRequest'

  
end

JobInvitation.auto_upgrade!
