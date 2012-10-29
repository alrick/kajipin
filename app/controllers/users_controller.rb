class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    if params[:id].nil?
      @user = User.includes(:locations).find(current_user)
    else
      @user = User.includes(:locations).find(params[:id])
    end
    @big_cities = @user.locations.bigcity
    @small_cities = @user.locations.smallcity
    @points_of_interest = @user.locations.pointofinterest
  end

  def index
    @users = User.where("id != '#{current_user.id}'")
  end
end
