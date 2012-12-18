class GalleriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @galleries = @pin.galleries

    respond_to do |format|
      format.js
    end
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
