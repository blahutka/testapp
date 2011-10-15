# -*- encoding : utf-8 -*-
class SkillRequestsController < ApplicationController
  inherit_resources
  actions :all, :except => :index
  respond_to :js, :only => :skill

  def new
    new!
  end

  def skill
    term = params[:term].downcase if params.key?(:term)
    render :json => SkillTag.named_like_any(term, :any => true).to_json(:only => [:id, :name, :wiki])
    #render :json => SkillTag.where(["name LIKE ?", "%#{term}%"]).collect(&:name)
  end

end
