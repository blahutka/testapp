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

  it 'not logged', :driver => :selenium, :transactions => :true do
    FactoryGirl.create(:skill_tag)

    
    get '/skill_requirements/new'
    controller.logged_in?.should be_false
    response.should render_template(:new)
    
    post '/skill_requirements', :skill_requirement => attributes_for(:skill_requirement_valid)
    #

    follow_redirect!
    response.should redirect_to(login_path)


  end

  it 'is logged', :driver => :selenium, :transactions => :false do
    FactoryGirl.create(:skill_tag, :synonym_list => 'zednik')
    user = FactoryGirl.create(:home_owner)
    post '/user_sessions', :email => 'petr@localhost', :password => 'petr'
    controller.logged_in?.should be_true

    get '/skill_requirements/new'
    #login_user(user)
    response.should render_template(:new)

    controller.logged_in?.should be_true
    post '/skill_requirements', :skill_requirement => attributes_for(:skill_requirement_valid, :skill_list => 'zednik')
    skill_requirement = assigns(:skill_requirement)
    #login_user(user)

    follow_redirect!
    #login_user(user)
    response.should redirect_to(skill_requirement)
    response.body.should include('zednik')


  end

end