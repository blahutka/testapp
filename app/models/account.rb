# -*- encoding : utf-8 -*-
class Account < ActiveRecord::Base
  field :email, :type => :string
  field :phone, :type => :string

  has_many :profiles
  has_many :projects
  
end

Account.auto_upgrade!
