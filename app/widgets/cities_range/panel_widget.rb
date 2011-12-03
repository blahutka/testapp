# -*- encoding : utf-8 -*-
class CitiesRange::PanelWidget < Apotomo::Widget
  include Sorcery::Controller::InstanceMethods

  responds_to_event :list_update
  responds_to_event :display
  responds_to_event :modal

  #after_initialize :find_city


  has_widgets do |panel|
    map_city
    list_cities(params[:range])
    panel << widget("cities_range/list", :list, :cities => @options[:cities], :range => @options[:range])
    panel << widget("cities_range/map", :map_content, :circle => @options[:circle], :mark => @options[:mark])
  end

  def display
    render
  end

  def modal
    #render(:state => :display)
    update '#my-modal .modal-body .wrap', render(:state => :display)
  end

  def list_update(data)
    binding.pry
    self.list_cities(data[:range])
  end

  protected

  def profile
    @profile ||= @options[:profile].presence || AccountProfile.find_by_id(params[:profile_id])
  end

  def city
    @city ||= City.where(:name => self.profile.city, :zip => self.profile.zip).first ||
        City.where(:name => 'Brno').first
  end

  def map_city
    meters = ((self.profile.radius.presence || AccountProfile::DEFAULT_RADIUS) * 1000)

    @options[:circle] = self.city.to_circle(meters).to_json
    @options[:mark] = self.city.to_mark.to_json
    @options[:city] = self.city
  end

  def list_cities(meters=nil)
    kilometers = (meters.presence || (self.profile.radius*1000)).to_i / 1000
    @options[:range] = kilometers
    @options[:cities] = City.order('name').near(self.city.full_address, kilometers).all
  end


end
