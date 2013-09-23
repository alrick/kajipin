class PinsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!, :except => :show

  # Cancan authorize
  load_and_authorize_resource

  def show
    # If current_user is an herald, no need to authenticate
    if !current_user.instance_of?(Herald)
      authenticate_user!
    end
    @pin = Pin.find(params[:id])
    @photos = @pin.photos
    @comments = @pin.comments
    
    render layout: false
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def update
    @pin = Pin.find(params[:id])
    @old_type = @pin.type
    @pin.update_attributes(:type => params[:type])
    @pin = @pin.becomes(params[:type].constantize)

    respond_to do |format|
      format.js
    end
  end

  def create
    @pin = Pin.new({ ext_id: params[:geoname_id], type: params[:type], user_id: current_user.id})

    if @pin.save
      redirect_to user_url(current_user), notice: t('controllers.pins.create.success', title: @pin.title)
    else
      redirect_to user_url(current_user), alert: t('controllers.pins.create.fail')+beautiful_errors(@pin)
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    respond_to do |format|
      format.js
    end
  end
end
