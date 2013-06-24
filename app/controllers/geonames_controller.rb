class GeonamesController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!

  respond_to :json
  def index
    @geonames = Geoname.search(params[:q])
  end

end