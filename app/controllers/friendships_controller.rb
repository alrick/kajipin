class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def index
    sharings = current_user.friends
    sharers = current_user.inverse_friends
    bmates = (sharings+sharers).uniq.sort_by(&:first_name)
    @mates = Kaminari.paginate_array(bmates).page(params[:page]).per(48)
  end

  def create
    friend = User.find(params[:friend])
    if !current_user.isSharing(friend)
      @friendship = current_user.friendships.build(:friend_id => friend.id)
      @friendship.save
    end

    respond_to do |format|
      format.js
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
