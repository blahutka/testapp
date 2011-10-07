# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_invitation do
    association :to, :factory => :account_profile
    association :from, :factory => :skill_request
  end
end