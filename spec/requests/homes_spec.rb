require 'spec_helper'

describe "Homes" do
  before :each do
    #@homes = [stub_model(Home, :created_at => '12.11.2009')]
    @post = mock_model(Home, :created_at => '2011-08-16 14:48:50')
    Home.stub(:all).and_return([@post])
    #Home.create!(:created_at => '2011-08-16 14:48:50')
  end


  describe "GET /homes" do
    it "works! (now write some real specs)" do
      #mock_model(Home, :created_at => '12.11.2009')
      visit homes_path
      page.save_and_open_page 
      within('table#homes-id') do
        page.should have_content('2011-08-16 14:48:50')
      end

    end
  end
end
