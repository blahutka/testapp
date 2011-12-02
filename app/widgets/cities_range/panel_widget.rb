# -*- encoding : utf-8 -*-
class CitiesRange::PanelWidget < Apotomo::Widget
  responds_to_event :list_update, :with => :update_list, :on => :list
  responds_to_event :display
  responds_to_event :modal

  has_widgets do |panel|
    profile = @options[:profile].presence || AccountProfile.find_by_id(params[:profile_id])
    #binding.pry
    panel << widget("cities_range/list", :list, :profile =>  profile)
    panel << widget("cities_range/map", :map_content, :profile => profile)
  end

  def display()
    render
  end

  def modal
    #render(:state => :display)
    update '#my-modal .modal-body .wrap', render(:state => :display)
  end


end
