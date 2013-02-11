class RequestsController < ApplicationController
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
end
