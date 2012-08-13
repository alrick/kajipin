class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    if params[:id].nil?
      @user = User.includes(:locations).find(current_user)
    else
      @user = User.includes(:locations).find(params[:id])
    end
  end
end
