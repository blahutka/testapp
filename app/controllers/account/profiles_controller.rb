class Account::ProfilesController < ApplicationController
  inherit_resources
  defaults :resource_class => AccountProfile, :collection_name => 'profiles', :instance_name => 'profile'
  respond_to :html, :json


  has_widgets do |root|
    root << widget('cities_range/panel', 'cities-panel', :address => @profile.try(:full_address) || params[:address])
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
      success.json { render(:json => { :located => resource.geocoded?, :full_address => resource.full_address }) }
    end
  
end

def show
  @json = resource.to_gmaps4rails
  show!
end

protected
def begin_of_association_chain
  current_account
end


end
