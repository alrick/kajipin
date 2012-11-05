require 'nokogiri'

class UsersController < GeoController
  layout "map", :only => [:show]
  before_filter :authenticate_user!
  before_filter :get_user, :only => [:show]
  before_filter :get_countries, :only => [:show]

  def show
    @pins = @user.locations

    get_list
    get_countries
    init_pins
    focus_pin
    focus_bounds
  end

  def index
    @users = User.where("id != '#{current_user.id}'")
  end

  # Get a list of pins
  def get_list
    @big_cities = @user.locations.bigcity
    @small_cities = @user.locations.smallcity
    @points_of_interest = @user.locations.pointofinterest
  end

  # Get user to display the map
  def get_user
    if params[:id].nil?
      redirect_to user_path(current_user)
      return
    end
    @user = User.find(params[:id])
  end

  # Init JSON pins via rabl
  def init_pins
    gon.rabl "app/views/locations/index.json.rabl", as: "pins"
  end

  # Focus on a pin if set (MAP)
  def focus_pin
    if !params[:p].nil?
      p = Location.find(params[:p])
      gon.plat = p.latitude
      gon.plon = p.longitude
    end
  end

  # Focus bounds if country selected (MAP)
  def focus_bounds
    if (!params[:w].nil? and !params[:n].nil? and !params[:e].nil? and !params[:s].nil?)
      gon.west = params[:w]
      gon.north = params[:n]
      gon.east = params[:e]
      gon.south = params[:s]
    end
  end
  
end
