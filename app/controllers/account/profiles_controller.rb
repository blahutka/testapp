class Account::ProfilesController < ApplicationController
  layout proc {|controller| controller.request.xhr? ? false: "application" }
  
  inherit_resources
  defaults :resource_class => AccountProfile, :collection_name => 'profiles', :instance_name => 'profile'
  respond_to :html, :json, :js


  has_widgets do |root|
    root << widget('cities_range/panel', 'cities-panel',
                   :address => @profile.try(:full_address) || params[:address],
                   :radius => @profile.try(:radius) || params[:radius])
  end

  def index
    index!
  end

  def new
    new!
  end

  def create
    create! do |success, failure|
      success.html { redirect_to(profile_path(resource)) }
    end
  end

  def update
    @json = resource.to_gmaps4rails
    update! do |success, failure|
      success.json { render(:json => {:located => resource.geocoded?, :radius => resource.radius, :full_address => resource.full_address}) }
      success.js {}
      success.html { }
    end

  end

  def show
    @json = resource.to_gmaps4rails
    show!
  end

  def destroy
    destroy!
  end

  protected
  def begin_of_association_chain
    current_account
  end


end
