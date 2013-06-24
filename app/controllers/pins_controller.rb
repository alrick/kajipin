class PinsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource

  def new
    respond_to do |format|
      format.js
    end
  end

  def update
    @pin = Pin.find(params[:id])
    @pin.update_attributes(:type => params[:type])
    @pin = @pin.becomes(params[:type].constantize)

    respond_to do |format|
      format.js
    end
  end

  def create
    @pin = params[:type].constantize.new
    @pin.init(params[:geoname_id], current_user.id)

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
