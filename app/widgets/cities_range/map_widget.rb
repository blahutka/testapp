class CitiesRange::MapWidget < Apotomo::Widget
  responds_to_event :range_changed
  responds_to_event :update
  
  def display
    render :locals => {:circle => @options[:circle], :mark => @options[:mark]}
  end

  def update
    render :state => :display

  end

  def range_changed(data)
    trigger :list_update, data
  end

end