# -*- encoding : utf-8 -*-
class Account < ActiveRecord::Base
  field :email, :type => :string
  field :phone, :type => :string

  has_many :profiles, :class_name => 'AccountProfile'
  has_many :job_invitations, :through => :profiles, :source => :invitations

  has_many :skill_requests
  has_many :users

end

Account.auto_upgrade!
