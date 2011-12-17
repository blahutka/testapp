# -*- encoding : utf-8 -*-
class CitiesRange::PanelWidget < ApplicationWidget
  #include Sorcery::Controller::InstanceMethods
  #helper :application
  #include ApplicationHelper
  #include ActionView::Helpers::UrlHelper
  #helper ActionView::Helpers::UrlHelper

  #parent_controller.current_account

  responds_to_event :list_update
  responds_to_event :map_update
  responds_to_event :display
  responds_to_event :iframe
  responds_to_event :modal

  #after_initialize :setup!


  has_widgets do |panel|

    mark_city(self.address, self.radius)
    panel << widget("cities_range/map", :map_content, :radius => @options[:radius],
                    :circle => @options[:circle], :mark => @options[:mark])

    list_cities(self.address, self.radius)
    panel << widget("cities_range/list", :list, :cities => @options[:cities],
                    :radius => @options[:radius])
  end

  def setup!
    binding.pry
  end

  def display
    render :layout => 'page'
  end


  def iframe
    render
  end

  def modal
    js_modal_box(render :state => :iframe)
  end

  def map_update
    replace "iframe", :state => :iframe
  end

  def list_update(data)
    #self.list_cities(data[:address], data[:radius])
  end

  protected

  def location
    @location ||= begin
      search = Geocoder.search(self.address)
      search.empty? ? nil : search.first.data['geometry']['location']
    end
  end

  attr_accessor :address

  def to_circle(radius)
    meters = (radius.to_i * 1000)
    [self.location.merge('radius' => meters)]
  end

  def to_mark
    [self.location]
  end

  def mark_city(address, radius)
    @options[:radius] = radius
    if location
      @options[:circle] = self.to_circle(radius).to_json
      @options[:mark] = self.to_mark.to_json
    end
  end

  def list_cities(address, radius)
    @options[:cities] = City.order('name').near(address, radius).all
  end

  def radius
    params[:radius] || @options[:radius]
  end

  def address
    (params[:address] || @options[:address]) || 'Brno, Česká republika'
  end

  def disable?
    @options[:disable] = true if self.address.nil?
  end

  def profile
    #@profile ||= parent_controller.send :resource
  end


end
