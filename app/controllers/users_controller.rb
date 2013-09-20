class UsersController < ApplicationController
  include ApplicationHelper # Require to access view helpers from gon rabl
  include PhotoHelper # Require to access view helpers from gon rabl
  
  before_filter :get_user, :only => [:show]

  layout "map", :only => [:show]

  def index
    :authenticate_user!
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
    end
  end

  # Get user to display the map
  def get_user
    @herald = Herald.find_by_key(params[:key])
    if current_user.instance_of?(User)
      :authenticate_user!
      if params[:id].nil?
        redirect_to user_url(current_user)
      else
        @user = User.find(params[:id])
      end
    elsif current_user.instance_of?(Herald)
      @user = @herald.user
    end
  end
  
end
