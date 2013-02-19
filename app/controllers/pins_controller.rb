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

  def index
    @user = current_user
    get_pins
    open_tab
    @pin_limit = PIN_LIMIT
  end

  def list
    @user = User.find(params[:user])
    get_pins

    respond_to do |format|
      format.js
    end
  end

  def new
    if params[:q].blank?
      q = "london"
    else
      q = CGI.escape(params[:q])
    end

    url = ENV["GEONAMES_SEARCH_URL"]+q+"&maxRows="+MAXROWS+"&fuzzy="+FUZZY+"&username="+ENV["GEONAMES_USERNAME"]
    @geos = JSON.parse(open(url).read)

    if @geos["status"]
      redirect_to pins_url, alert: "<strong>Oh snap!</strong> Can't communicate with Geonames, please try again later."
    end
  end

  def update
    @pin = Pin.find(params[:id])

    # Can't edit high populated pins
    if @pin.high_populated?
      redirect_to pins_url, alert: "<strong>Oh snap!</strong> You can't edit high populated pins."
    else
      @pin.type = params[:type]

      if @pin.save
        tab = Pin.find(params[:id]).get_tab
        redirect_to pins_url(:tab => tab), notice: "<strong>#{@pin.title}</strong> was successfully updated."
      else
        redirect_to pins_url(:tab => @pin.get_tab), alert: "<strong>Oh snap!</strong> Something went wrong while updating #{@pin.title}."
      end
    end
  end

  def create
    # Init getters for pin
    id = params[:ext_id]
    type = params[:type] if [Bigcity.sti_name, Smallcity.sti_name, Poi.sti_name].include? params[:type]
    @pin = init_pin(id,type)

    if @pin.save
      redirect_to pins_url(:tab => @pin.get_tab), notice: "<strong>#{@pin.title}</strong> was successfully added to your pins."
    else
      redirect_to pins_url, alert: "<strong>Oh snap!</strong> Something went wrong while creating your pin. #{@pin.errors.get(:user)}"
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    redirect_to pins_url(:tab => @pin.get_tab), notice: "<strong>#{@pin.title}</strong> was successfully removed from your pins."
  end

  # Generic method to get pins
  def get_pins
    @big_cities = @user.pins.bigcity
    @small_cities = @user.pins.smallcity
    @points_of_interest = @user.pins.poi
    @overall = @user.pins
  end

  # Init pin with geonames data
  def init_pin(id,type)
    # Get data from Geonames
    url = ENV["GEONAMES_GET_URL"]+id+"&username="+ENV["GEONAMES_USERNAME"]
    result = JSON.parse(open(url).read)

    # Can communicate with Geonames?
    if result["status"]
      redirect_to pins_url, alert: "<strong>Oh snap!</strong> Can't communicate with Geonames, please try again later."
    end

    # Force high populated pins to big city
    if result["population"] >= 1000000
      type = Bigcity.sti_name
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

  # Open right tab regarding params (SHOW)
  def open_tab
    if params[:tab] == "s" or params[:tab] == "p"
      gon.tab = params[:tab]
    end
  end
end
