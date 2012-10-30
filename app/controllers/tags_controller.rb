class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.order(:name)
  end
end
