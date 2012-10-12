require 'nokogiri'

class PinsController < GeoController
  layout "map", :only => [:index]
  before_filter :get_user
  before_filter :get_countries, :only => [:index]

  def index
    @pins = @user.locations
    @pins_bigcity = init_bigcity
    @pins_smallcity = init_smallcity
    @pins_pointofinterest = init_pointofinterest

    get_countries
    init_pins
    focus_pin
    focus_bounds
  end

  def show
    @pin = @user.locations.find(params[:id])

    # get all comment for this location
    @comments = @pin.comments.order('created_at ASC')
    
    # prepare the comment for user
    @comment = Comment.new

    #open right tab
    open_tab
  end

  # Get user to display the map
  def get_user
    @user = User.find(params[:user_id])
  end

  # Init JSON bigcity pins
  def init_bigcity
    locatid = Locategory.where(:hook => 1)
    @user.locations.where(:locategory_id => locatid)
  end

  # Init JSON smallcity pins
  def init_smallcity
    locatid = Locategory.where(:hook => 2)
    @user.locations.where(:locategory_id => locatid)
  end

  # Init JSON pointofinterest pins
  def init_pointofinterest
    locatid = Locategory.where(:hook => 3)
    @user.locations.where(:locategory_id => locatid)
  end

  # Init JSON pins via rabl
  def init_pins
    gon.rabl "app/views/pins/index.json.rabl", as: "pins"
    gon.rabl "app/views/pins/gon/bigcity.json.rabl", as: "bigcity"
    gon.rabl "app/views/pins/gon/smallcity.json.rabl", as: "smallcity"
    gon.rabl "app/views/pins/gon/pointofinterest.json.rabl", as: "pointofinterest"
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

  # Open right tab regarding params (SHOW)
  def open_tab
    if params[:t] == "l" or params[:t] == "c"
      gon.tab = params[:t]
    end
  end
end