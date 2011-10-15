# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :account_profile do
    name 'Default account'

    factory :contractor_profile do
      sequence(:name) { |n| "Contractor-profile-#{n}" }
      association :account, :factory => :contractor_account
      skill_list 'zednik, pokryvac,   naterac'
    end
  end

end
