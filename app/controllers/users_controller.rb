class UsersController < ApplicationController
  
  # Devise authentication
  before_filter :authenticate_user!
  
  before_filter :get_user, :only => [:show]

  layout "map", :only => [:show]

  def index
    busers = User.where("id != '#{current_user.id}'").search(params[:q])
    @users = Kaminari.paginate_array(busers).page(params[:page]).per(20)
    @q = "All"
    @q = params[:q] if params[:q] && params[:q] != ""
  end

  def show
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
  end

  def modal
    @user = User.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  # Get user to display the map
  def get_user
    # If no id provided, auto redirect to the logged user profile
    if params[:id].nil?
      redirect_to user_url(current_user)
    else
      @user = User.find(params[:id])
    end
  end
  
end
