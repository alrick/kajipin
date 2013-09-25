class HeraldsController < ApplicationController
  # Devise authentication
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource

  def index
    @herald = current_user.herald

    respond_to do |format|
      format.js
    end
  end

  def create
    @herald = current_user.create_herald

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @herald = current_user.herald
    @herald.destroy

    respond_to do |format|
      format.js
    end
  end

end