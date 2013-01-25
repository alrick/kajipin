class LogpagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @logpages = @pin.logpages.all

    respond_to do |format|
      format.js
    end
  end

  def create
    @logpage = @pin.logpages.build(params[:logpage])
    @logpage.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @logpage = Logpage.find(params[:id])
    @logpage.update_attributes(params[:logpage])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @logpage = Logpage.find(params[:id])
    @logpage.destroy

    respond_to do |format|
      format.js
    end
  end

  def manage
    @logpage = @pin.logpages.build
    @logpages = @pin.logpages.all
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end