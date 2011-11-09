# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  layout 'application'
  protect_from_forgery

  before_filter :require_login, :except => [:not_authenticated]

  helper_method :current_users_list

  protected


  
  def not_authenticated
    redirect_to login_path(:anchor => 'login-form'), :alert => "Please login first."
  end

  def current_users_list
    current_users.map { |u| u.email }.join(", ")
  end

  helper_method :current_account
  before_filter :te

  def te
    #binding.pry
  end

  #before_filter :set_default_account_id, :if => lambda { current_user }
  #def set_default_account_id
  #  self.default_url_options[:account_id] = current_account.id
  #end

  def current_account
    @current_account ||= current_user.account.presence if current_user
  end

end
