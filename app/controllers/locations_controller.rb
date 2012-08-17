require 'open-uri'
require 'json'

class LocationsController < ApplicationController
  before_filter :get_user
  before_filter :get_locations, :only => [:index, :manage]
  before_filter :get_location, :only => [:show, :edit, :update, :destroy]
  before_filter :check_auth, :only => [:edit, :update, :destroy]

  def get_user
    if params[:user_id].nil?
      @user = current_user
    else
      @user = User.find(params[:user_id])
    end
  end

  def get_location
    @location = @user.locations.find(params[:id])
  end

  def get_locations
    @locations = @user.locations
  end

  def check_auth

  end

  def index
    gon.rabl "app/views/locations/index.json.rabl", as: "locations"

    # Get location if map opened via a single location
    if !params[:l].nil?
      gon.highloc = params[:l]
    end

    render :layout => 'map'
  end

  def show
    # show.html.erb
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

  def edit
    # edit.html.erb
  end

  def manage
    # manage.html.erb
  end

  def create
    location = current_user.locations.create
    location.title = params[:title]
    location.latitude = params[:latitude]
    location.longitude = params[:longitude]
    location.country_name = params[:country_name]
    location.country_code = params[:country_code]

    if location.save
      redirect_to manage_user_locations_url(current_user), notice: '<strong>Well done!</strong> Location was successfully added.'
    else
      redirect_to manage_user_locations_url(current_user), alert: '<strong>Oh snap!</strong> Something went wrong.'
    end
  end

  def update
    if @location.update_attributes(params[:location])
      redirect_to @location, notice: '<strong>Well done!</strong> Location was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @location.destroy

    redirect_to manage_user_locations_url(current_user), notice: '<strong>Well done!</strong> Location was successfully removed.'
  end
end
