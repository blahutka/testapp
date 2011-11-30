# -*- encoding : utf-8 -*-
class CitiesRange::PanelWidget < Apotomo::Widget
  responds_to_event :list_update, :with => :update, :on => :list

  has_widgets do |panel|
    panel << widget("cities_range/list", :list, :profile => @options[:profile])
    panel << widget("cities_range/map", :map_content, :profile => @options[:profile])
  end

  def display
    render
  end


end
