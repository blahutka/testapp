# -*- encoding : utf-8 -*-
class PriceBid < ActiveRecord::Base
  field :account_profile, :type => :references
  field :job_invitation, :type => :references
  field :price, :type => :integer

  belongs_to :account_profile
  belongs_to :job_invitation
end

PriceBid.auto_upgrade!
