class SkillRequirementsController < ApplicationController
  inherit_resources
  actions :all, :except => :index
  respond_to :js, :only => :skill
  skip_before_filter :require_login, :only => [:new, :create, :show, :edit, :update]
  
  before_filter :skill_tags
  #before_filter :redirect_to_edit, :only => :new
  after_filter :save_cookie_public_id, :only => [:create, :update]


  def new
    @skill_tags = SkillTag.top_master_tags(15)
    #@skill_tags_json = @skill_tags.inject({}){ |result,r|  result[r.id] = {:id => r.id, :name => r.name, :wiki => r.wiki }; result}.to_json
    #@skill_tags_json = @skill_tags.to_json(:only => [:id, :name, :wiki])
    @skill_tags_json = SkillTag.top_to_hash.to_json
    @skill_tags_menu = @skill_tags.collect { |v| [v.name, v.name] }
    new!
  end

  def show
    show!
  end

  def create

    @skill_list = Tag.find_by_name(params[:skill_requirement][:skill_list]) || false
    create! do |success, failure|
      success.html do

        flash[:notice] = 'Specify more' and render :template => 'skill_requirements/specify' unless @skill_list
        redirect_to skill_requirement_path(@skill_requirement) if @skill_list
      end
    end
  end

  def edit
    edit!
  end

  def skill
    term = params[:term].downcase if params.key?(:term)
    render :json => SkillTag.named_like_any(term, :any => true).to_json(:only => [:id, :name, :wiki])
    #render :json => SkillTag.where(["name LIKE ?", "%#{term}%"]).collect(&:name)
  end

  private

  def skill_tags
    @skill_tags = SkillTag.top_master_tags(15)
    @skill_tags_menu = @skill_tags.collect { |v| [v.name, v.name] }
  end

  def redirect_to_edit
    if cookies['public_id'].presence
      if @skill_requirement = SkillRequirement.find_by_public_id(cookies['public_id'])
        redirect_to(edit_skill_requirement_path(@skill_requirement))
      end
    end
  end

  def save_cookie_public_id
    unless logged_in?
      cookies['public_id'] = @skill_requirement.public_id
    end
  end
end
