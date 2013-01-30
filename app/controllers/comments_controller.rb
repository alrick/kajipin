class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

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

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
