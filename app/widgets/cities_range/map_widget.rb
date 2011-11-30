class CitiesRange::MapWidget < Apotomo::Widget
  responds_to_event :range_changed

  def display
    profile = options[:profile]
    city = profile.city; zip = profile.zip; radius = (profile.radius * 1000)
    city = City.where(:name => city, :zip => zip).first
    circle = city.to_circle; circle[0][:radius] = radius
    
    render :locals => {:circle => circle.to_json, :mark => city.to_mark.to_json}
  end

  def range_changed(data)
    trigger :list_update, data
  end

end