class SkillRequirementsController < ApplicationController
  inherit_resources
  actions :all, :except => :index
  respond_to :js, :only => :skill
  before_filter :skill_tags
  skip_before_filter :require_login

  def new
    @skill_tags = SkillTag.top_master_tags(15)
    #@skill_tags_json = @skill_tags.inject({}){ |result,r|  result[r.id] = {:id => r.id, :name => r.name, :wiki => r.wiki }; result}.to_json
    #@skill_tags_json = @skill_tags.to_json(:only => [:id, :name, :wiki])
    @skill_tags_json = SkillTag.top_to_hash.to_json
    @skill_tags_menu = @skill_tags.collect{|v|[v.name,v.name]}
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

  def skill
    term = params[:term].downcase if params.key?(:term)
    render :json => SkillTag.named_like_any(term, :any => true).to_json(:only => [:id, :name, :wiki])
    #render :json => SkillTag.where(["name LIKE ?", "%#{term}%"]).collect(&:name)
  end

  private

  def skill_tags
    @skill_tags = SkillTag.top_master_tags(15)
    @skill_tags_menu = @skill_tags.collect{|v|[v.name,v.name]}
  end
end
