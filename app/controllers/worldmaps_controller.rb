class WorldmapsController < ApplicationController
  def index
    render :layout => 'map'
  end
end