# Read about factories at http://github.com/thoughtbot/factory_girl
require 'factory_girl'

FactoryGirl.define do

  factory :account do |account|
    account.email 'accout@localhost.com'
    account.phone '771 223 333'

    factory :account_with_profile do
      after_create do
        FactoryGirl.create(:profile_with_project_invitations, :account_id => self.id)
      end
    end

    
  end
end