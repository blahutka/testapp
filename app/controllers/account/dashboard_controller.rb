class Account::DashboardController < ApplicationController
  def index
      @skill_requests = current_account.skill_requests
  end
end
