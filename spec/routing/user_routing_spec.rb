require "rspec"
# http://rubydoc.info/gems/rspec-rails/frames

describe "user rounting" do

  it "should do something" do
    {:get => "/users/index"}.should route_to(:controller => "users", :action => "index")
  end
end