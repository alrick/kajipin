class GalleriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @galleries = @pin.galleries

    respond_to do |format|
      format.js
    end
  end

  def create
    @gallery = @pin.galleries.build(params[:gallery])
    @gallery.normalized = @gallery.title.gsub(/[^0-9A-Za-z]/, '')
    @gallery.accesstoken_id = current_user.accesstoken.id

    if @gallery.save
      redirect_to manage_pin_galleries_path(@pin), notice: "OK"
    else
      redirect_to manage_pin_galleries_path(@pin), alert: "NOT"
    end
  end


  def manage
    if current_user.accesstoken.blank?
      redirect_to edit_user_registration_url, alert: "<strong>Oh snap!</strong> You've to add a Dropbox account in order to add galleries."
    end

    @galleries = @pin.galleries
    @gallery = @pin.galleries.build
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
