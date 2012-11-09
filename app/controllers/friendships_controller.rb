class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def index
    sharings = current_user.friends
    sharers = current_user.inverse_friends
    @mates = (sharings+sharers).uniq.sort_by(&:first_name)
  end

  def create
    friend = User.find(params[:friend])
    if !current_user.isSharing(friend)
      @friendship = current_user.friendships.build(:friend_id => friend.id)

      if @friendship.save
        respond_to do |format|
          format.html { redirect_to friendships_path, notice: "You are now sharing with #{@friendship.friend.first_name}." }
          format.js
        end
      else
        redirect_to friendships_path, alert: "<strong>Oh snap!</strong> Something went wrong, please retry."
      end
    else
      redirect_to friendships_path, alert: "<strong>Oh snap!</strong> You are already sharing with #{@friendship.friend.first_name}."
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy

    # Allow js format for remote call
    respond_to do |format|
      format.html { redirect_to friendships_path, notice: "You do not share with #{@friendship.friend.first_name} anymore." }
      format.js
    end
  end
end
