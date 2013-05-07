require 'nokogiri'

class UsersController < GeoController
  
  # Devise authentication
  before_filter :authenticate_user!
  
  before_filter :get_user, :only => [:show]
  before_filter :get_countries, :only => [:show]

  layout "map", :only => [:show]

  def index
    busers = User.where("id != '#{current_user.id}'").search(params[:q])
    @users = Kaminari.paginate_array(busers).page(params[:page]).per(20)
    @q = "All"
    @q = params[:q] if params[:q] && params[:q] != ""
  end

  def show
    gon.mapbox_id = ENV["MAPBOX_ID"]
    if can? :read, @user

      # Check user has added pins
      gon.hasPins = !@user.pins.empty?

      # Generate geojson for each type of pins
      @pins = @user.pins.city
      gon.watch.rabl "app/views/pins/geo.json.rabl", as: "bctPins"
      @pins = @user.pins.town
      gon.watch.rabl "app/views/pins/geo.json.rabl", as: "townPins"
      @pins = @user.pins.poi
      gon.watch.rabl "app/views/pins/geo.json.rabl", as: "poiPins"
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
