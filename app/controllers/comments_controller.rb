class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @comments = @pin.comments
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      redirect_to :back, notice: "Comment was successfully created."
    else
      redirect_to :back, alert: "<strong>Oh snap!</strong> Can't add your comment, give us another chance!"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
