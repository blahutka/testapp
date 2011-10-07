# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :account_profile do
    sequence(:name) { |n| "Zednik-profil-#{n}" }
    association :account

    factory :profile_with_invitations do
      after_create do
        FactoryGirl.create(:project_invitation, :from => self.id)
      end
    end
  end

end