class Account::ProfilesController < ApplicationController
  inherit_resources
  defaults :resource_class => AccountProfile, :collection_name => 'profiles', :instance_name => 'profile'

  include Apotomo::Rails::ControllerMethods

  has_widgets do |root|
    root << widget('cities_range/panel', 'cities-panel', :profile => @profile)
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
      success.js do
        render :update do |page|
          page << 'ok'
        end

      end
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
