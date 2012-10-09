require 'nokogiri'

class PinsController < GeoController
  before_filter :get_user
  before_filter :get_countries, :only => [:index]

  def index
    @pins = @user.locations

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

  # Init JSON pins via rabl
  def init_pins
    gon.rabl "app/views/pins/index.json.rabl", as: "pins"
  end

  # Focus on a pin if set
  def focus_pin
    if !params[:p].nil?
      gon.p = params[:p]
    end
  end

  # Focus bounds if country selected
  def focus_bounds
    if (!params[:w].nil? and !params[:n].nil? and !params[:e].nil? and !params[:s].nil?)
      gon.west = params[:w]
      gon.north = params[:n]
      gon.east = params[:e]
      gon.south = params[:s]
    end
  end

  # Open right tab regarding params
  def open_tab
    if params[:t] == "l" or params[:t] == "c"
      gon.tab = params[:t]
    end
  end
end