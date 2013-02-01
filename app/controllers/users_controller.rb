require 'nokogiri'

class UsersController < GeoController
  
  # Devise authentication
  before_filter :authenticate_user!
  
  before_filter :get_user, :only => [:show]
  before_filter :get_countries, :only => [:show]

  layout "map", :only => [:show]

  def index
    busers = User.where("id != '#{current_user.id}'").search(params[:q])
    @users = Kaminari.paginate_array(busers).page(params[:page]).per(48)
    @q = ""
    @q = params[:q] if params[:q]
  end

  def show
    if can? :read, @user
      @pins = @user.pins

      get_countries
      init_pins
      focus_pin
      focus_bounds
    else
      render :noshow
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
  
end
