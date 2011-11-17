# -*- encoding : utf-8 -*-

Given /^I am logged in$/ do
  steps %Q{
   And I am on the login page
   And an user_valid exist
   When within form new user session
   And I fill in "email" with "test@localhost.com"
   And I fill in "password" with "password"
   And I click on button "Vstup"
   Then I should see my name test@localhost.com
  }
end

When /^I am logged out$/ do
  #session.reset!
  visit root_path
  page.find('a#account').text.should include('Můj účet')
end
When /^I log in$/ do
  step  "I am logged in"
end

Then /^I should see my name (.*)$/ do |my_name|
  page.find('a#account').text.should include(my_name)
end