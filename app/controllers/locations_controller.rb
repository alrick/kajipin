
class LocationsController < ApplicationController
  before_filter :get_user
  before_filter :get_location, :only => [:show, :edit, :update, :destroy]
  before_filter :check_auth, :only => [:edit, :update, :destroy]

  def get_user
    if params[:user_id].nil?
      @user = current_user
    else
      @user = User.find(params[:user_id])
    end
  end

  def get_location
    @location = @user.locations.find(params[:id])
  end

  def check_auth

  end

  def index
    @locations = @user.locations
    gon.rabl "app/views/locations/index.json.rabl", as: "locations"
    render :layout => 'map'
  end

  def show
    # show.html.erb
  end

  def new
    @location = Location.new

    # new.html.erb
  end

  def edit
    # edit.html.erb
  end

  def create
    @location = Location.new(params[:location])

    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @location.update_attributes(params[:location])
      redirect_to @location, notice: 'Location was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @location.destroy

    redirect_to locations_url
  end
end
