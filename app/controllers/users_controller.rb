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
      gon.mapbox_id = ENV["MAPBOX_ID"]
      gon.watch.rabl "app/views/pins/index.json.rabl", as: "pins"
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
