class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.includes(:locations).find(params[:id])
  end
end
