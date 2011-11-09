# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  field :first_name, :type => :string
  field :last_name, :type => :string
  field :nickname, :type => :string
  field :picture_url, :type => :string
  field :email, :type => :string, :null => false
  field :crypted_password, :type => :string
  field :salt, :type => :string
  field :created_at, :type => :datetime
  field :updated_at, :type => :datetime
  field :activation_state, :type => :string
  field :activation_token, :type => :string
  field :activation_token_expires_at, :type => :datetime
  field :remember_me_token, :type => :string
  field :remember_me_token_expires_at, :type => :datetime
  field :reset_password_token, :type => :string
  field :reset_password_token_expires_at, :type => :datetime
  field :reset_password_email_sent_at, :type => :datetime
  field :last_login_at, :type => :datetime
  field :last_logout_at, :type => :datetime
  field :last_activity_at, :type => :datetime
  field :failed_logins_count, :type => :integer, :default => 0
  field :lock_expires_at, :type => :datetime
  field :type, :type => :string
  field :account, :type => :references

  add_index ["activation_token"]
  add_index ["email"]
  add_index ["last_logout_at", "last_activity_at"]
  add_index ["remember_me_token"]

  belongs_to :account

  attr_accessible :email, :password, :password_confirmation, :providers_attributes

  has_many :authentication_providers, :dependent => :destroy
  accepts_nested_attributes_for :authentication_providers

  authenticates_with_sorcery!

  validates :email, :presence => true
  #validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  #validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  before_create :create_account

  def create_account
    self.build_account(:email => self.email)
  end
end

User.auto_upgrade!
