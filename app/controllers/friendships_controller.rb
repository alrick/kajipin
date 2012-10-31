class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user

    #open right tab
    open_tab
  end

  def create
    if !current_user.isSharing(params[:friend])
      @friendship = current_user.friendships.build(:friend_id => params[:friend])

      if @friendship.save
        redirect_to friendships_path(:t => "s"), notice: "You are now sharing with #{@friendship.friend.first_name}."
      else
        redirect_to friendships_path(:t => "s"), alert: "<strong>Oh snap!</strong> Something went wrong, please retry."
      end
    else
      redirect_to friendships_path(:t => "s"), alert: "<strong>Oh snap!</strong> You are already sharing with #{@friendship.friend.first_name}."
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy

    redirect_to friendships_path(:t => "s"), notice: "You do not share with #{@friendship.friend.first_name} anymore."
  end

  # Open right tab regarding params (SHOW)
  def open_tab
    if params[:t] == "s"
      gon.tab = params[:t]
    end
  end
end
