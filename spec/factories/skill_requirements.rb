# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory :skill_requirement do

    factory :skill_requirement_valid do
      skill_list 'zedník'
      when_type 'flexible'
      when_flexible 'anytime'
      where 'Brno'
      description 'Opravit dvere'

    end
  end
end