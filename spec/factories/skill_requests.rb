# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_request do


    #state 'created'
    factory :home_owner_request do
      sequence(:title) { |n| "Home-owner-request-#{n}" }
      association :account, :factory => :home_owner_account
    end
  end
end
