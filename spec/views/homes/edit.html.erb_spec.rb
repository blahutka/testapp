# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "homes/edit.html.erb" do
  before(:each) do
    @home = assign(:home, stub_model(Home))
  end

  it "renders the edit home form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => homes_path(@home), :method => "post" do
    end
  end
end
