class TagsController < ApplicationController

  def index
    @tags = Tag.order(:name)
  end
end
