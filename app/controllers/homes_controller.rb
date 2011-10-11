# -*- encoding : utf-8 -*-
class HomesController < ApplicationController

  def index
  end

  def worker
    Resque.enqueue(Eat, params[:food])
    render :text => 'worker:' + params[:food] + " #{Time.now}"
  end
end
