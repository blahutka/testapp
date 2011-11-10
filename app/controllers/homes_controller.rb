# -*- encoding : utf-8 -*-
class HomesController < ApplicationController
  skip_before_filter :require_login

  def index
    #binding.pry
    track! :home
  end

  def worker
    Resque.enqueue(Eat, params[:food])
    render :text => 'worker:' + params[:food] + " #{Time.now}"
  end
end
