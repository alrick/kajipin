require 'open-uri'
require 'json'

class PinsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource

  # Global vars
  MAXROWS = "20"
  FUZZY = "0.8"
  GEONAMES_SEARCH_URL = "http://api.geonames.org/searchJSON?q="
  GEONAMES_GET_URL = "http://api.geonames.org/getJSON?geonameId="

  def new
    if params[:q].blank?
      q = "london"
    else
      q = CGI.escape(params[:q])
    end

    url = GEONAMES_SEARCH_URL+q+"&maxRows="+MAXROWS+"&fuzzy="+FUZZY+"&username="+ENV["GEONAMES_USERNAME"]
    @geos = JSON.parse(open(url).read)

    if @geos["status"]
      redirect_to pins_url, alert: t('controllers.pins.geonames_error')
    end
  end

  def update
    @pin = Pin.find(params[:id])
    @pin.update_attributes(:type => params[:type])
    @pin = @pin.becomes(params[:type].constantize)

    respond_to do |format|
      format.js
    end
  end

  def create
    # Init getters for pin
    id = params[:ext_id]
    type = params[:type] if [City.sti_name, Town.sti_name, Poi.sti_name].include? params[:type]
    @pin = init_pin(id,type)

    if @pin.save
      redirect_to pins_url(:tab => @pin.get_tab), notice: t('controllers.pins.create.success', title: @pin.title)
    else
      redirect_to pins_url, alert: t('controllers.pins.create.fail')+beautiful_errors(@pin)
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    respond_to do |format|
      format.js
    end
  end

  # Init pin with geonames data
  def init_pin(id,type)
    # Get data from Geonames
    url = GEONAMES_GET_URL+id+"&username="+ENV["GEONAMES_USERNAME"]
    result = JSON.parse(open(url).read)

    # Can communicate with Geonames?
    if result["status"]
      redirect_to pins_url, alert: t('controllers.pins.geonames_error')
    end

    # Set datas
    pin = type.constantize.new()
    pin.user_id = current_user.id
    pin.title = result["toponymName"]
    pin.latitude = result["lat"]
    pin.longitude = result["lng"]
    pin.country_name = result["countryName"]
    pin.country_code = result["countryCode"]
    pin.continent_code = result["continentCode"]
    pin.ext_id = result["geonameId"]
    pin.population = result["population"]

    return pin
  end
end
