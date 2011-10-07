#require 'factory_girl'
## http://robots.thoughtbot.com/post/254496652/aint-no-calla-back-girl
#
#Factory.sequence :email do |n|
#  "email_#{n}@localhost.com"
#end
#
#FactoryGirl.define do
#  factory :user do
#
#  end
#end
#
#
#FactoryGirl.define do
#
#
#
#  #factory :assignment do
#  #
#  #  factory :assignment_admin do |f|
#  #    association :role, :factory => :role_admin
#  #    #association( :user, :factory => :user_petr) {}
#  #  end
#  #
#  #  factory :assignment_superadmin do
#  #    association :role, :factory => :role_superadmin
#  #  end
#  #end
#  #
#  #factory :role do
#  #
#  #  factory :role_admin, :parent => :role do
#  #    name 'admin'
#  #  end
#  #
#  #  factory :role_superadmin do
#  #    name 'superadmin'
#  #  end
#  #
#  #end
#  #
#  #
#  #factory :user do |f|
#  #  f.email 'blahutka@centrum.cz'
#  #  f.password 'petrpetr'
#  #  f.password_confirmation { |f| f.password }
#  #
#  #  factory :user_petr do |f|
#  #
#  #    after_create do
#  #      Factory.create(:assignment_admin, :user => self)
#  #      Factory.create(:assignment_superadmin, :user => self)
#  #    end
#  #  end
#  #end
#  #
#  #factory :article do |article|
#  #  article.title 'Name'
#  #  article.content 'text'
#  #  article.association :article_category
#  #end
#  #
#  #factory :image do
#  #
#  #  factory :image_with_file do
#  #    attachment File.new(File.join(::Rails.root, 'spec', 'fixtures', 'rails.png'))
#  #  end
#  #end
#  #
#  #factory :attachment do |obj|
#  #  obj.association :image
#  #  obj.attachable { |i| i.association(:asset) }
#  #end
#  #
#  #
#  #factory :file_attachment do
#  #
#  #end
#  #
#  #factory :asset do
#  #
#  #end
#  #
#  #factory :product do
#  #
#  #end
#  #
#  #factory :article_category do |f|
#  #  f.name "Categorie 1"
#  #end
#  #
#  #factory :email_entry do
#  #  email 'test@email.com'
#  #end
#
#end