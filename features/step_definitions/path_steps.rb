Then(/^(.+?) should match route (\/.*)$/) do |page, route|
  regexp = route.gsub(/:(\w*?)id/,'\d+')
  path_to(page).should =~ /#{regexp}/
end

When(/^I go to (.+)$/) do |page|
  visit path_to(page)
end

Given(/^I am on (.+)$/) do |page|
  visit path_to(page)
end

Then(/^I should be at (.+)$/) do |page|
  current_url.should =~ /#{path_to(page)}/
end
Then /^I am on the #{capture_model}'s page$/ do |model_name|
  model =  model_name.gsub(' ', '_').camelize.constantize.last
  current_path.should == post_comments_path(post)
end