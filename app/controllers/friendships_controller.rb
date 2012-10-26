class FriendshipsController < ApplicationController

  def index
    @user = current_user
  end

  def create
    if !current_user.isSharing(params[:friend_id])
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

      if @friendship.save
        redirect_to friendships_path, notice: "You are now sharing with #{@friendship.friend.first_name}."
      else
        redirect_to friendships_path, alert: '<strong>Oh snap!</strong> Something went wrong, please retry.'
      end
    else
      redirect_to friendships_path, alert: "<strong>Oh snap!</strong> You are already sharing with #{@friendship.friend.first_name}."
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy

    redirect_to friendships_path, notice: "You do not share with #{@friendship.friend.first_name} anymore."
  end
end
