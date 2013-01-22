require 'open-uri'
require 'json'

class PinsController < ApplicationController
  before_filter :authenticate_user!
  GEONAMES_USERNAME = "&username=curlyb"
  GEONAMES_MAXROWS = "&maxRows=20"
  GEONAMES_FUZZY = "&fuzzy=0.8"
  GEONAMES_FEATURES = "&featureClass=H&featureClass=L&featureClass=P&featureClass=R&featureClass=S&featureClass=T&featureClass=U&featureClass=V"

  def index
    @user = current_user
    @big_cities = @user.pins.bigcity
    @small_cities = @user.pins.smallcity
    @points_of_interest = @user.pins.pointofinterest
    open_tab
  end

  def new
    @locategories = Locategory.order(:id)
    @pin = Pin.new

    if params[:q].nil?
      q = "london"
    else
      q = URI.escape(params[:q])
    end

    url = "http://api.geonames.org/searchJSON?q="+q+GEONAMES_MAXROWS+GEONAMES_FUZZY+GEONAMES_FEATURES+GEONAMES_USERNAME
    @geos = JSON.parse(open(url).read)

    if @geos["status"]
      redirect_to pins_url, alert: "<strong>Oh snap!</strong> Can't communicate with Geonames, please try again later."
      return
    end
  end

  def edit
    @locategories = Locategory.order(:id)
    @pin = Pin.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])

    if @pin.update_attributes(params[:pin])
      redirect_to pins_url(:tab => @pin.locategory.get_tab), notice: "<strong>#{@pin.title}</strong> was successfully updated."
    else
      redirect_to pins_url(:tab => @pin.locategory.get_tab), alert: "<strong>Oh snap!</strong> Something went wrong while updating #{@pin.title}."
    end
  end

  def create
    @pin = Pin.new
    @pin.user_id = current_user.id
    @pin.title = params[:title]
    @pin.latitude = params[:latitude]
    @pin.longitude = params[:longitude]
    @pin.country_name = params[:country_name]
    @pin.country_code = params[:country_code]
    @pin.locategory_id = params[:locategory]
    @pin.ext_id = params[:ext_id]

    if @pin.save
      redirect_to pins_url(:tab => @pin.locategory.get_tab), notice: "<strong>#{@pin.title}</strong> was successfully added to your pins."
    else
      redirect_to pins_url, alert: "<strong>Oh snap!</strong> Something went wrong while creating your pin."
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    # Allow js format for remote call
    respond_to do |format|
      format.html { redirect_to pins_url, notice: "<strong>#{@pin.title}</strong> was successfully removed from your pins." }
      format.js
    end
  end

  # Open right tab regarding params (SHOW)
  def open_tab
    if params[:tab] == "s" or params[:tab] == "p"
      gon.tab = params[:tab]
    end
  end

end
