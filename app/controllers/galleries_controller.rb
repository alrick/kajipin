class GalleriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @galleries = @pin.galleries

    respond_to do |format|
      format.js
    end
  end

  def manage
    if Accesstoken.has_token_type(current_user, Dropboxtoken.sti_name)
      @galleries = @pin.galleries.order("created_at ASC")
    else
      redirect_to accesstokens_url, alert: "<strong>Oh snap!</strong> You've to link a Dropbox account in order to add galleries."
    end
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
