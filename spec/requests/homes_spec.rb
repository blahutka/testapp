require 'spec_helper'

describe "Homes" do
  describe "GET /homes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get homes_path
      save_and_open_page
      response.status.should be(200)
    end 
  end
end
