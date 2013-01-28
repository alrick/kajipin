class GalleriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @gallery = @pin.gallery

    begin
      client = get_client
      @photos = client.ls @gallery.path
      @thumb = @photos.first.path.thumbnail
    rescue Exception => e
      @dropbox_error = true
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    if !is_accesstoken
      redirect_to edit_user_registration_url, alert: "<strong>Oh snap!</strong> You've to add a Dropbox account in order to add galleries."
    else
      @gallery = @pin.build_gallery
      @gallery.accesstoken_id = current_user.accesstoken.id

      begin
        client = get_client
        client.mkdir @gallery.path
      rescue Exception => e
        redirect_to(pins_url(:tab => @pin.locategory.get_tab), alert: "<strong>Oh snap!</strong> Something went wrong with Dropbox, please try again later or remove and add again your account.") and return
      end

      if @gallery.save
        redirect_to pins_url(:tab => @pin.locategory.get_tab), notice: "Gallery for <strong>#{@pin.title}</strong> successfully created."
      else
        redirect_to pins_url(:tab => @pin.locategory.get_tab), alert: "<strong>Oh snap!</strong> Gallery for <strong>#{@pin.title}</strong> can't be created."
      end
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])

    begin
      client = get_client
      gallery_dir = client.find @gallery.path
      gallery_dir.destroy
    rescue Exception => e
      redirect_to(pins_url(:tab => @pin.locategory.get_tab), alert: "<strong>Oh snap!</strong> Something went wrong with Dropbox, please try again later or remove and add again your account.") and return
    end

    @gallery.destroy
    redirect_to pins_url(:tab => @pin.locategory.get_tab), notice: "Gallery for <strong>#{@pin.title}</strong> successfully removed."
  end

  # Check if user has set an accesstoken
  def is_accesstoken
    !current_user.accesstoken.blank?
  end

  # Get dropbox client
  def get_client
    accesstoken = current_user.accesstoken
    client = Dropbox::API::Client.new :token => accesstoken.token, :secret => accesstoken.secret
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
