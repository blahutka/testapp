class Account::ProfilesController < ApplicationController
  inherit_resources
  defaults :resource_class => AccountProfile, :collection_name => 'profiles', :instance_name => 'profile'
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

  def show
    show! 
  end

  protected
  def begin_of_association_chain
    current_account
  end

end
