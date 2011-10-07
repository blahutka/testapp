# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_request do
    sequence(:title) { |n| "Request-skill-#{n}"}
    #state 'created'
    association :account
  end
end