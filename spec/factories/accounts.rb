# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :account do
    email 'default@email.com'
    phone '000 000 000'

    factory :contractor_account do
      email 'peter@contractor.com'
      phone '800 111 111'
    end

    factory :home_owner_account do
      email 'home@gmail.com'
      phone '771 223 333'
    end

        
  end
end
