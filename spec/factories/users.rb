# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    association :account

    factory :home_owner do
      email 'petr@localhost'
      salt "asdasdastr4325234324sdfds"
      crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("petr", salt) }
      activation_state 'active'
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
