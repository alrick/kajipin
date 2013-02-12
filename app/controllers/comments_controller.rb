class CommentsController < ApplicationController
  # Cancan authorize
  load_and_authorize_resource :pin
  load_and_authorize_resource :comment, :through => :pin

  # Devise authentication
  before_filter :authenticate_user!

  def index
    @comment = @pin.comments.build
    @page = params[:page]
    @comments = @pin.comments.page(@page).per(10)

    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @pin.comments.build(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      last_page = @pin.comments.page(1).per(10).num_pages
      redirect_to pin_comments_url(@pin, :page => last_page)
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    page = params[:page]

    if @comment.destroy
      last_page = @pin.comments.page(1).per(10).num_pages
      # Determine page to display, current or last if current is empty
      if page.to_i > last_page.to_i
        page = last_page
      end
      
      redirect_to pin_comments_url(@pin, :page => page)
    else
      respond_to do |format|
        format.js
      end
    end
  end
end
