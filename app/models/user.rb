# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  field :first_name, :type => :string
  field :last_name,  :type => :string
  field :email,      :type => :string
  field :account,    :type => :references

  belongs_to :account
end

User.auto_upgrade!
