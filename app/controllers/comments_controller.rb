class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @comments = @pin.comments

    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      @comment.save
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.pin.user == current_user
      @comment.destroy
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
