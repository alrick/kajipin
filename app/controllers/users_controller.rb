class UsersController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!, :except => :show
  before_filter :get_user, :only => [:show]

  layout "map", :only => [:show]

  def index
    busers = User.where("id != '#{current_user.id}'").search(params[:q])
    @users = Kaminari.paginate_array(busers).page(params[:page]).per(20)
    @q = "All"
    @q = params[:q] if params[:q] && params[:q] != ""
  end

  def show
    # Set the key if herald
    gon.key = @herald.key if !@herald.nil?

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
      gon.watch.rabl "app/views/pins/index.json.rabl", as: "cities"
      @pins = @user.pins.town
      gon.watch.rabl "app/views/pins/index.json.rabl", as: "towns"
      @pins = @user.pins.poi
      gon.watch.rabl "app/views/pins/index.json.rabl", as: "pois"

      # Reset pins to all pins for the list
      @pins = @user.pins

      # Check showcase partner
      if params[:partner] == "swiss"
        gon.swiss = true
        @swiss = true
      end
      if params[:mode] == "full"
        gon.noUser = true
      end
    end
  end

  # Get user to display the map
  def get_user
    @herald = Herald.find_by_key(params[:key])
    # If current_user is an herald, no need to authenticate
    if current_user.instance_of?(Herald)
      @user = @herald.user
    else
      authenticate_user!
      if params[:id].nil?
        redirect_to user_url(current_user)
      else
        @user = User.find(params[:id])
      end
    end
  end
  
end
