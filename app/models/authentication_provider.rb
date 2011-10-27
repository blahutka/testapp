class AuthenticationProvider < ActiveRecord::Base
  field :user_id,    :type => :references, :null => false
  field :provider,   :type => :string,     :null => false
  field :uid,        :type => :string,     :null => false
  field :created_at, :type => :datetime
  field :updated_at, :type => :datetime

  belongs_to :user
end

AuthenticationProvider.auto_upgrade!
