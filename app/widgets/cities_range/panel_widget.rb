# -*- encoding : utf-8 -*-
class CitiesRange::PanelWidget < Apotomo::Widget
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

  #after_initialize :find_city


  has_widgets do |panel|
    map_city(params[:address] || @options[:address])
    #list_cities(params[:range])
    #panel << widget("cities_range/list", :list, :cities => @options[:cities], :range => @options[:range])
    panel << widget("cities_range/map", :map_content, :circle => @options[:circle], :mark => @options[:mark])
  end

  def display
    render :layout => 'page'
  end


  def iframe
   render
  end

  def modal
    #render(:state => :display)
    update '#my-modal .modal-body .wrap', render(:state => :display)
  end

  def map_update
    replace "iframe", :state => :iframe
  end

  def list_update(data)
    self.list_cities(data[:range])
  end

  protected

  def profile
    @profile ||= @options[:profile].presence || AccountProfile.find_by_id(params[:profile_id])
  end

  def location
    @location ||= begin
       search = Geocoder.search(self.address)
       search.empty? ? nil : search.first.data['geometry']['location']
    end

  end

 attr_accessor :address

  def to_circle(meters)
    [self.location.merge('radius' => meters)]
  end

  def to_mark
    [self.location]
  end

  def map_city(address, radius = nil)
    radius = AccountProfile::DEFAULT_RADIUS if radius.blank?
    self.address = address
    meters = (radius * 1000)

    @options[:circle] = self.to_circle(meters).to_json
    @options[:mark] = self.to_mark.to_json
  end

  def list_cities(meters=nil)
    kilometers = (meters.presence || (self.profile.radius*1000)).to_i / 1000
    @options[:range] = kilometers
    @options[:cities] = City.order('name').near(self.city.full_address, kilometers).all
  end


end
