class Account::DashboardController < ApplicationController
  def index
    @graph = Koala::Facebook::GraphAPI.new(session['access_token'])
    @me = @graph.get_picture('me', :type => '')
    @skill_requests = current_account.skill_requests
  end
end
