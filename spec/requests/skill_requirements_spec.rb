# -*- encoding : utf-8 -*-
require "spec_helper"

describe 'Form add requirement' do

  it "should show calendar", :js => true, :driver => :webkit do
    visit new_skill_requirement_path
    choose('Přesně stanovený den:')
    #select('Kalendář', :from => 'calendar')
    find("#calendar").click
    find('#calendar-holder').click_on('27')
    find('#calendar_chzn').should have_content('27.10.2011')
    page.should have_content 'říjen'
    page.evaluate_script("$('#skill_requirement_when_1_date').val()").should have_content('27.10.2011')
    #page.save_and_open_page
  end
end