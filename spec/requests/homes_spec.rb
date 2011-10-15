# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Homes" do
  before :each do
    #@homes = [stub_model(Home, :created_at => '12.11.2009')]
    @post = FactoryGirl.create(:home_owner_request)
    SkillRequest.stub(:all).and_return([@post])
    #Home.create!(:created_at => '2011-08-16 14:48:50')
  end


  describe "GET /homes" do
    it "works! (now write some real specs)" do
      #mock_model(Home, :created_at => '12.11.2009')
      visit homes_path
      page.save_and_open_page
      within('h1') do
        page.should have_content('ebujete')
      end

    end
  end
end
