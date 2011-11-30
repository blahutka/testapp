# -*- encoding : utf-8 -*-
class CitiesRange::ListWidget < Apotomo::Widget
  
  
  def display(data={})
    profile = options[:profile]
    range = (data[:range].presence || (profile.radius*1000)).to_i / 1000
    cities = City.order('name').near('Křižanovice, 68501, Česká republika', range).all
    render :locals => {:range => range, :cities => cities }
  end

   def update(data)
     replace "#list", {:state => 'display'}, data
  end

end