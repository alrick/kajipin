
class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags, :except=>  [:id, :created_at, :updated_at] }
    end
  end
end
