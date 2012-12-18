class LogpagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @logpages = @pin.logpages

    respond_to do |format|
      format.js
    end
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
