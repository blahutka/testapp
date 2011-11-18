class Account::SkillRequestsController < ApplicationController
  inherit_resources

  def index

  end

  def new
    @skill_requirement = SkillRequirement.find_by_public_id(params[:public]) if params[:public]
    new!
  end

  def show
    show!
  end

  def create
    #@skill_requirement = SkillRequirement.find_by_id(params[:skill_request][:skill_requirement_attributes][:id])
    #@skill_request = current_account.skill_requests.build
    #@skill_request.skill_requirement = @skill_requirement
    #resource.approve!
    create! do |success, failure|
      success.html { resource.approve!; redirect_to(dashboard_path) }
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html { redirect_to(dashboard_path) }
    end
  end

  protected
  def begin_of_association_chain
    current_account
  end

end
