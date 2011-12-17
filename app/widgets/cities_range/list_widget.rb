# -*- encoding : utf-8 -*-
class CitiesRange::ListWidget < Apotomo::Widget
  
  
  def display(data={})
    render :locals => {:radius => @options[:radius], :cities => @options[:cities ]}
  end

  # def update_list(data)
  #   replace "#list", {:state => 'display'}, data
  #end

end