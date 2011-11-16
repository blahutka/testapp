# -*- encoding : utf-8 -*-

Given /^I am logged in$/ do
  steps %Q{
   And I am on the login page
   And an user_valid exist
   When within form new user session
   And I fill in "email" with "test@localhost.com"
   And I fill in "password" with "password"
   And I click on button "Vstup"
   Then I should be at the dashboard page
   And the dashboard page should match route /dashboard
   And I should see info message with "Login successfull"
  }
end

When /^I am logged out$/ do
  #session.reset!
  visit root_path
  page.find('a#account').text.should include('Můj účet')
end