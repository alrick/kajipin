class CommentsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource :pin
  load_and_authorize_resource :comment, :through => :pin

  def index
    @comment = @pin.comments.build
    @page = params[:page] # required to pass current page to destroy action
    @comments = @pin.comments.page(@page).per(10)

    # Display last page if no more message in page set
    last = @comments.num_pages
    if @page.to_i > last
      @comments = @pin.comments.page(last).per(10)
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @pin.comments.build(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to pin_comments_url(@pin, :page => params[:last])
    else
      respond_to do |format|
        format.js
      end
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
