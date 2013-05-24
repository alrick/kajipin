class HeraldsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!, :except => [:show]

  # Cancan authorize, Herald must be init before authorization
  before_filter :init_herald, :only => [:show]
  load_and_authorize_resource

  # Layout
  layout "map", :only => [:show]

  def index
    @herald = current_user.herald

    respond_to do |format|
      format.js
    end
  end

  def show
    # Get related user
    @user = @herald.user

    # Set mapbox id from env config
    gon.mapbox_id = ENV["MAPBOX_ID"]

    # Get a list of all countries
    @countries_list = Country.list
    @visited_countries = Hash.new

    # Only if current user can read the profile
    if can? :read, @user

      # Countries the @user has pins to
      @visited_countries = @user.visited_countries

      # Check user has added pins
      gon.hasPins = !@user.pins.empty?

      # Generate geojson
      @pins = @user.pins.city
      gon.watch.rabl "app/views/pins/geo.json.rabl", as: "cities"
      @pins = @user.pins.town
      gon.watch.rabl "app/views/pins/geo.json.rabl", as: "towns"
      @pins = @user.pins.poi
      gon.watch.rabl "app/views/pins/geo.json.rabl", as: "poi"

      # Reset pins to all pins for side
      @pins = @user.pins
    end

    # Render the user
    render "users/show"
  end

  def create
    @herald = current_user.create_herald

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @herald = current_user.herald
    @herald.destroy

    respond_to do |format|
      format.js
    end
  end

  def init_herald
    @herald = Herald.find_by_key(params[:key]) || not_found
    session[:herald] = @herald.key
  end

end