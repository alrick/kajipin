class CommentsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource :pin
  load_and_authorize_resource :comment, :through => :pin

  def create
    @comment = @pin.comments.build(params[:comment])
    @comment.user_id = current_user.id

    @comment.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    page = params[:page]

    @comment.destroy
    respond_to do |format|
      format.js
    end
  end
end
