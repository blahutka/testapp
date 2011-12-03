class CitiesRange::MapWidget < Apotomo::Widget
  responds_to_event :range_changed

  def display
    render :locals => {:circle => @options[:circle], :mark => @options[:mark]}
  end

  def range_changed(data)
    trigger :list_update, data
  end

end