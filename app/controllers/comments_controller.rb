class CommentsController < ApplicationController
  # Cancan authorize
  load_and_authorize_resource :pin
  load_and_authorize_resource :comment, :through => :pin

  # Devise authentication
  before_filter :authenticate_user!

  def index
    @comment = @pin.comments.build
    @comments = @pin.comments.page(params[:page]) #default to 25

    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @pin.comments.build(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      num_pages = @pin.comments.page(1).num_pages
      redirect_to pin_comments_url(@pin, :page => num_pages)
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.pin.user == current_user
      @comment.destroy
    end

    respond_to do |format|
      format.js
    end
  end
end
