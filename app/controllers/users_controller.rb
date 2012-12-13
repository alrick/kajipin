require 'nokogiri'

class UsersController < GeoController
  layout "map", :only => [:show]
  before_filter :authenticate_user!
  before_filter :get_user, :only => [:show]
  before_filter :get_countries, :only => [:show]

  def index
    @users = User.where("id != '#{current_user.id}'").search(params[:q])
    @q = ""
    @q = params[:q] if params[:q]
  end

  def show
    if check_access
      @pins = @user.pins

      get_list
      get_countries
      init_pins
      focus_pin
      focus_bounds
    else
      render :noshow
    end
  end

  # Get a list of pins
  def get_list
    @big_cities = @user.pins.bigcity
    @small_cities = @user.pins.smallcity
    @points_of_interest = @user.pins.pointofinterest
  end

  # Get user to display the map
  def get_user
    # If no id provided, auto redirect to the logged user profile
    if params[:id].nil?
      redirect_to user_path(current_user)
      return
    end
    @user = User.find(params[:id])
  end

  # Init JSON pins via rabl
  def init_pins
    gon.watch.rabl "app/views/pins/index.json.rabl", as: "pins"
  end

  # Focus on a pin if set (MAP)
  def focus_pin
    if !params[:p].nil?
      p = Pin.find(params[:p])
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

  # Check if user can access map (user page)
  def check_access
    if @user == current_user
      return true
    elsif current_user.isSharer(@user)
      return true
    else
      return false
    end
  end
  
end
