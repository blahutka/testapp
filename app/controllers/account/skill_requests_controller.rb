class Account::SkillRequestsController < ApplicationController
  inherit_resources

  def new
    new!
  end

  def show
    show!
  end

  def create
    @skill_requirement = SkillRequirement.find_by_id(params[:skill_request][:skill_requirement_attributes][:id])
    @skill_request = current_account.skill_requests.build
    @skill_request.skill_requirement = @skill_requirement
    create! do |success, failure|
      success.html { redirect_to(home_path) }
    end
  end

  protected
  def begin_of_association_chain
    current_account
  end

  def build_resource(attributes = {})
    current_account.skill_requests.build(attributes)
  end
end
