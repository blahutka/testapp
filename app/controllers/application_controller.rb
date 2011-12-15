# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  #include Apotomo::Rails::ControllerMethods

  layout 'application'
  protect_from_forgery

  use_vanity :current_user

  before_filter :require_login, :except => [:not_authenticated]

  helper_method :current_users_list

  def current_account
    @current_account ||= current_user.account.presence if current_user
  end

  protected

  def not_authenticated
    redirect_to login_path(:anchor => 'login-form'), :alert => "Please login first."
  end

  def current_users_list
    current_users.map { |u| u.email }.join(", ")
  end

  helper_method :current_account

  def self.render_event_response
    page_updates = apotomo_request_processor.process_for(params)

    return render_iframe_updates(page_updates) if params[:apotomo_iframe]

    render :text => page_updates.join("\n"), :content_type => Mime::HTML
  end


end
