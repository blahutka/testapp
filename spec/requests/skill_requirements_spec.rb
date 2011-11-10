# -*- encoding : utf-8 -*-
require "spec_helper"

RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before(:each) { DatabaseCleaner.clean_with(:truncation) }
end

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

  it 'not logged', :driver => :webkit, :transactions => :false do
    FactoryGirl.create(:skill_tag)

    get '/skill_requirements/new'
    controller.logged_in?.should be_false
    response.should render_template(:new)

    response.should render_template(:show)
    post '/skill_requirements', :skill_requirement => attributes_for(:skill_requirement_valid)


    #follow_redirect!
    #response.should redirect_to(login_path)
  end

  it 'is logged', :driver => :webkit, :transactions => :false do
    FactoryGirl.create(:skill_tag, :synonym_list => 'zednik')
    user = FactoryGirl.create(:home_owner)
    user.save

    post '/user_sessions', :user_session => {:email => 'petr@localhost', :password => 'petr'}
    controller.logged_in?.should be_true


    get '/skill_requirements/new'
    response.should render_template(:new)


    post '/skill_requirements', :skill_requirement => attributes_for(:skill_requirement_valid, :skill_list => 'zednik')
    skill_requirement = assigns(:skill_requirement)
    response.should redirect_to(skill_requirement)
    follow_redirect!
    response.should render_template(:show)


    lambda { post '/account/skill_requests',
                  :skill_request => {:skill_requirement_attributes => {:id => skill_requirement.id}}
    }.should change(user.account.skill_requests, :count).by(1)
    assigns(:skill_requirement).should be_an_instance_of(skill_requirement)
    
    response.should redirect_to(home_path)
    follow_redirect!
    controller.logged_in?.should be_true

  end

end