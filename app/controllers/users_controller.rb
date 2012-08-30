class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    if params[:id].nil?
      @user = User.includes(:locations).find(current_user)
    else
      @user = User.includes(:locations).find(params[:id])
    end
  end

  def index
    #@users = User.all
    @users = User.where("id != '#{current_user.id}'")
  end
end
