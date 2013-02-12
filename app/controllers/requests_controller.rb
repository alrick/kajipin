class RequestsController < ApplicationController
  # Cancan authorize
  load_and_authorize_resource 

  # Devise authentication
  before_filter :authenticate_user!

  def index
    @requests = current_user.requests

    respond_to do |format|
      format.js
    end
  end

  def create
    @request = Request.new
    user = params[:user]
    requester = params[:requester]
    @request.user_id = user
    @request.requester_id = requester

    if @request.save
      redirect_to user_url(user), :notice => "Successfully created request."
    else
      redirect_to user_url(user), :alert => "<strong>Oh Snap!</strong> Something went wrong with your request, please retry."
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    
    respond_to do |format|
      format.js
    end
  end

  def approve
    @request = Request.find(params[:id])
    @friendship = Friendship.new
    @friendship.user_id = @request.user_id
    @friendship.friend_id = @request.requester_id

    if @friendship.save
      @request.destroy
    end

    respond_to do |format|
      format.js
    end
  end
end