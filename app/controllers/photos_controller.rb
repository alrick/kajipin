class PhotosController < ApplicationController
  # Devise authenticate
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource :pin
  load_and_authorize_resource :photo, :through => :pin

  def index
    @photos = @pin.photos.all

    respond_to do |format|
      format.js
    end
  end

  def new
    @key = ENV["FILEPICKER_KEY"]

    respond_to do |format|
      format.js
    end
  end

  def captain
    @photos = @pin.photos.all
  end

  # Func to create multiple photos
  def create_many
    # Init success
    @photos = params[:photos]
    @all_success = true

    # Iterate over each photos and create it
    @photos.each do |photo|
      @photo = @pin.photos.build(photo)
      @photo.handle = @photo.url.split("/").last
      authorize! :create, @photo # Use cancan to check authorization
      if !@photo.save
        @photo.delete_remote
        @all_success = false
      end
    end

    # Display right message
    if @all_success
      flash[:notice] = "<strong>Photos</strong> were successfully added."
    else
      flash[:alert] = "<strong>Oh snap!</strong> Something went wrong while adding your photos, some could not be added#{beautiful_errors(@photo)}"
    end

    # Respond with javascript because it's ajax request
    respond_to do |format|
      format.js
    end
  end

  # Func to destroy multiple photos
  def destroy_many
    # Get photos and init success
    @photos = Photo.find(params[:photo_ids])
    @all_success = true

    # Destroy each photo separately
    @photos.each do |photo|
      authorize! :destroy, photo # Use cancan to check authorization
      if !photo.destroy
        @all_success = false
      end
    end

    # Redirect to captain photos and display right message
    if @all_success
      redirect_to captain_pin_photos_url(@pin), notice: "<strong>Photos</strong> were successfully removed."
    else
      redirect_to captain_pin_photos_url(@pin), alert: "<strong>Oh snap!</strong> Something went wrong while removing your photos, some could not be removed."
    end
  end
end
