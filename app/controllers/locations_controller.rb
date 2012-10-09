require 'open-uri'
require 'json'

class LocationsController < GeoController

  def index
    @user = current_user
    @locations = @user.locations
  end

  def new
    @location = Location.new

    if params[:q].nil?
      q = "london"
    else
      q = URI.escape(params[:q])
    end

    url = "http://api.geonames.org/searchJSON?q="+q+"&maxRows="+Geonamesconfig.maxrows+"&fuzzy="+Geonamesconfig.fuzzy+"&username="+Geonamesconfig.username
    @geos = JSON.parse(open(url).read)
  end

  def create
    location = Location.new
    location.user_id = current_user.id
    location.title = params[:title]
    location.latitude = params[:latitude]
    location.longitude = params[:longitude]
    location.country_name = params[:country_name]
    location.country_code = params[:country_code]

    if location.save
      redirect_to locations_url, notice: '<strong>Well done!</strong> Location was successfully added.'
    else
      redirect_to locations_url, alert: '<strong>Oh snap!</strong> Something went wrong.'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    redirect_to locations_url, notice: '<strong>Well done!</strong> Location was successfully removed.'
  end
end
