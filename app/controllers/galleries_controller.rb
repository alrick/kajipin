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
    @gallery.normalized = @gallery.title.gsub(/[^0-9A-Za-z]/, '').downcase
    @gallery.accesstoken_id = current_user.accesstoken.id

    client = get_client
    path = @gallery.dropbox_path
    make_dir(client, path)

    if @gallery.save
      redirect_to manage_pin_galleries_url(@pin), notice: "Gallery <strong>#{@gallery.title}</strong> successfully created."
    else
      redirect_to manage_pin_galleries_url(@pin), alert: "<strong>Oh snap!</strong> Gallery <strong>#{@gallery.title}</strong> can't be created."
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    redirect_to manage_pin_galleries_url(@pin), notice: "Gallery <strong>#{@gallery.title}</strong> successfully removed."
  end

  def manage
    # Check user has linked a Dropbox account
    if current_user.accesstoken.blank?
      redirect_to edit_user_registration_url, alert: "<strong>Oh snap!</strong> You've to add a Dropbox account in order to add galleries."
    end

    @galleries = @pin.galleries
    @gallery = @pin.galleries.build
  end

  # Create Dropbox dir for the gallery
  def make_dir(client, path)
    begin
      client.mkdir path
    rescue Exception => e
      redirect_to manage_pin_galleries_url(@pin), alert: "<strong>Oh snap!</strong> Something went wrong with Dropbox, please try again later or remove and add again your account."
    end
  end

  # Get dropbox client
  def get_client
    begin
      accesstoken = current_user.accesstoken
      client = Dropbox::API::Client.new :token => accesstoken.token, :secret => accesstoken.secret
    rescue Exception => e
      redirect_to manage_pin_galleries_url(@pin), alert: "<strong>Oh snap!</strong> Something went wrong with Dropbox, please try again later or remove and add again your account."
    end
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
