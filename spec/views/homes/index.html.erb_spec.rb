require 'spec_helper'

describe "homes/index.html.erb" do
  before(:each) do
    assign(:homes, [
      stub_model(Home),
      stub_model(Home)
    ])
  end

  it "renders a list of homes" do
    render
  end
end
