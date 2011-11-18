# -*- encoding : utf-8 -*-

When /^I choose "([^"]*)" with "([^"]*)"$/ do |selector, value|
  within(selector) do
    page.choose(value)
  end
end
When /^I choose "([^"]*)"$/ do |value|
  page.choose(value)
end
When /^I select "([^"]*)" with "([^"]*)"$/ do |selector, value|
  within("##{@form_id}") do
    page.select value, :from => "#{@model_name}[#{selector}]"
  end
end

When /^save and open page$/ do
  page.save_and_open_page
end

When /^within form (\w+)? (.*)$/ do |action, model|
  @model_name = model.gsub(' ', '_')
  @form_id = [action, @model_name].join('_')
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |selector, value|
  within("##{@form_id}") do
    page.fill_in("#{@model_name}[#{selector}]", :with => value)
  end
end
When /^I click on button "(.*)"$/ do |value|
  within("##{@form_id}") do
    page.click_link_or_button(value)
  end
end

Then /^I should see notice message with "([^"]*)"$/ do |msg|
  page.within('div.alert-message.info') do |t|
    #  page.has_content?('niddc')
    page.text.should include(msg)
    #page.has_content?(msg).should be_true
  end
end

Then /^I should see preview message with "([^"]*)"$/ do |msg|
  page.within('div.alert-message.block-message') do |t|
    page.text.should include(msg)
  end
end

When /^the last #{capture_model} created$/ do |model_name|
  instance = find_model(model_name)
  puts instance.inspect
end

When /^I follow "([^"]*)"$/ do |name|
  page.click_link(name)
end