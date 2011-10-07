class User < ActiveRecord::Base
  field :first_name, :type => :string
  field :email,      :type => :string
end

User.auto_upgrade!
