# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "Repair_wall_#{n}"}
    #association :account
    
  end
end
