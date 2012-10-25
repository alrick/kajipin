require 'open-uri'
require 'json'

class LocationsController < GeoController

  def index
    @user = current_user
    @locations = @user.locations
  end

  def new
    @locategories = Locategory.order(:id)
    @location = Location.new

    if params[:q].nil?
      q = "london"
    else
      q = URI.escape(params[:q])
    end

    url = "http://api.geonames.org/searchJSON?q="+q+"&maxRows="+Appetizer.geonames_maxrows+"&fuzzy="+Appetizer.geonames_fuzzy+"&username="+Appetizer.geonames_username
    @geos = JSON.parse(open(url).read)
  end

  def edit
    @locategories = Locategory.order(:id)
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    if @location.update_attributes(params[:location])
      flash[:notice] = 'Location was successfully updated.'
      redirect_to locations_url, notice: '<strong>Success!</strong> Location was correctly modified.'
    else
      redirect_to locations_url, alert: '<strong>Oh snap!</strong> Something went wrong.'
    end
  end

  def create
    location = Location.new
    location.user_id = current_user.id
    location.title = params[:title]
    location.latitude = params[:latitude]
    location.longitude = params[:longitude]
    location.country_name = params[:country_name]
    location.country_code = params[:country_code]
    location.locategory_id = params[:locategory]

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
