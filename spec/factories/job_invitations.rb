# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_invitation do
    created_at Time.now

    factory :home_owner_with_contractor_invitation do
      association :to, :factory => :contractor_profile
      association :from, :factory => :home_owner_request

    end
  end
end
