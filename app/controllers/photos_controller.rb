class PhotosController < ApplicationController
  # Devise authenticate
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource :pin
  load_and_authorize_resource :photo, :through => :pin

  def index
    @photos = @pin.photos.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.js
    end
  end

  def captain
    @photos = @pin.photos.all
  end

  # Func to create photos coming from Filepicker.io
  def create_all
  def create_many

    # Init counts
    count = 0

    # Iterate over each photos
    params[:photos].each do |photo|
      @photo = @pin.photos.build(photo)
      if !@photo.save
        count+=1
      end
    end

    # Compare counts to know if ALL photos have been created
    if count > 0
      flash[:alert] = "<strong>Oh snap!</strong> Something went wrong while adding your photos, some could not be added."
    else
      flash[:notice] = "<strong>Photos</strong> were successfully added."
    end

    respond_to do |format|
      format.json { render json: flash }
    end
  end
end
