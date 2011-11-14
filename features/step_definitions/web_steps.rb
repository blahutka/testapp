#When /^I go to home page$/ do
#  visit home_path
#end
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
  @model_name = model[/^#{capture_model}$/].gsub(' ', '_')
  @form_id = [action, @model_name].join('_')
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |selector, value|
  within("##{@form_id}") do
    page.fill_in("#{@model_name}[#{selector}]", :with => value)
  end
end
When /^I click on button "(.*)"$/ do |value|
  within("##{@form_id}") do
    page.click_button(value)
  end
end
Then /^I should see info message with "([^"]*)"$/ do |msg|
  page.within('div.alert-message.info') do |t|
    #  page.has_content?('niddc')
    page.text.should include(msg)
    #page.has_content?(msg).should be_true
  end
end