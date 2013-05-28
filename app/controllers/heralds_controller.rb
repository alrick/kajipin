class HeraldsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!, :only => [:index, :create, :destroy]

  # Cancan authorize
  load_and_authorize_resource

  # Setup accessors
  before_filter :init_accessor, :only => [:photos, :comments, :logpages]

  # Layout
  layout "map", :only => [:show]

  def index
    @herald = current_user.herald

    respond_to do |format|
      format.js
    end
  end

  def show
    # Get related user
    @herald = Herald.find_by_key(params[:key]) || not_found
    @user = @herald.user

    # Master is used to check permissions
    @master = @herald

    # Set mapbox id from env config
    gon.mapbox_id = ENV["MAPBOX_ID"]

    # Get a list of all countries
    @countries_list = Country.list

    # Countries the @user has pins to
    @visited_countries = @user.visited_countries

    # Check user has added pins
    gon.hasPins = !@user.pins.empty?

    # Generate geojson
    @pins = @user.pins.city
    gon.watch.rabl "app/views/heralds/geo.json.rabl", as: "cities"
    @pins = @user.pins.town
    gon.watch.rabl "app/views/heralds/geo.json.rabl", as: "towns"
    @pins = @user.pins.poi
    gon.watch.rabl "app/views/heralds/geo.json.rabl", as: "poi"

    # Reset pins to all pins for side
    @pins = @user.pins

    # Render the user
    render "users/show"
  end

  def create
    @herald = current_user.create_herald

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @herald = current_user.herald
    @herald.destroy

    respond_to do |format|
      format.js
    end
  end

  # Accessors

  def photos
    @photos = @pin.photos.all

    respond_to do |format|
      format.js { render 'photos/index' }
    end
  end

  def comments
    @page = params[:page] # required to pass current page to destroy action
    @comments = @pin.comments.page(@page).per(10)

    # Display last page if no more message in page set
    last = @comments.num_pages
    if @page.to_i > last
      @comments = @pin.comments.page(last).per(10)
    end

    respond_to do |format|
      format.js { render 'comments/index' }
    end
  end

  def logpages
    @logpages = @pin.logpages.page(params[:page]).per(10)

    respond_to do |format|
      format.js { render 'logpages/index' }
    end
  end

  def init_accessor
    @herald = Herald.find_by_key(params[:key])
    @pin = Pin.find(params[:pin])

    # Check pin accessed is really related to herald
    if @herald.user != @pin.user
      raise CanCan::AccessDenied.new("Not authorized!")
    end
  end

end