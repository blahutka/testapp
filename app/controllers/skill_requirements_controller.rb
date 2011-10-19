class SkillRequirementsController < ApplicationController
  inherit_resources
  actions :all, :except => :index
  respond_to :js, :only => :skill
  before_filter :skill_tags

  def new
    @skill_tags = SkillTag.top_master_tags(15)
    #@skill_tags_json = @skill_tags.inject({}){ |result,r|  result[r.id] = {:id => r.id, :name => r.name, :wiki => r.wiki }; result}.to_json
    #@skill_tags_json = @skill_tags.to_json(:only => [:id, :name, :wiki])
    @skill_tags_json = SkillTag.top_to_hash.to_json
    @skill_tags_menu = @skill_tags.collect{|v|[v.name,v.id]}
    new!
  end

  def show
    show!
  end

  def create

    create!
  end

  def skill
    term = params[:term].downcase if params.key?(:term)
    render :json => SkillTag.named_like_any(term, :any => true).to_json(:only => [:id, :name, :wiki])
    #render :json => SkillTag.where(["name LIKE ?", "%#{term}%"]).collect(&:name)
  end

  private

  def skill_tags
    @skill_tags = SkillTag.top_master_tags(15)
    @skill_tags_menu = @skill_tags.collect{|v|[v.name,v.id]}
  end
end
