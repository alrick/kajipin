class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      redirect_to :back, notice: 'Comment was successfully created.'
    else
      redirect_to :back, alert: '<strong>Oh snap!</strong> Can\'t add your comment, give us another chance!'
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
end
