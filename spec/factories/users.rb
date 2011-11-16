# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    #association :account

    factory :user_valid do
      email 'test@localhost.com'
      salt "asdasdastr4325234324sdfds"
      crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("password", salt) }
      activation_state 'active'
    end

    factory :home_owner do
      email 'test@localhost.com'
      salt "asdasdastr4325234324sdfds"
      crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("password", salt) }
      activation_state 'active'
      after_create do
        #self.activate!
        #self.account { FactoryGirl.create(:home_owner_account) }
      end
    end

    factory :admin_user do
      first_name 'Admin'
      last_name 'Admin'
      email 'admin@localhost.com'
    end

    factory :moderator_user do
      first_name 'Moderator'
      last_name 'Moderator'
      email 'moderator@localhost.com'
    end
  end
end
