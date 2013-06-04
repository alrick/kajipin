class RequestsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource

  def index
    @requests = current_user.requests.page(params[:page]).per(6)
    @page = params[:page] # required to pass current page to destroy action

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
      redirect_to user_url(user), :notice => t('requests.create.success')
    else
      redirect_to user_url(user), :alert => t('requests.create.fail')
    end
  end

  def destroy
    @request = Request.find(params[:id])
    page = params[:page]

    if @request.destroy
      last_page = current_user.requests.page(1).per(6).num_pages
      # Determine page to display, current or last if current is empty
      if page.to_i > last_page.to_i
        page = last_page
      end
      
      redirect_to requests_url(:page => page)
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def approve
    @request = Request.find(params[:id])
    @friendship = Friendship.new
    @friendship.user_id = @request.user_id
    @friendship.friend_id = @request.requester_id
    page = params[:page]

    if @request.destroy
      @friendship.save
      last_page = current_user.requests.page(1).per(6).num_pages
      # Determine page to display, current or last if current is empty
      if page.to_i > last_page.to_i
        page = last_page
      end
      
      redirect_to requests_url(:page => page)
    else
      respond_to do |format|
        format.js { render :action => "destroy" }
      end
    end
  end
end