class FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all
    @watcherships = Friendship.where(:user_id => current_user.id)
    @sharerships = Friendship.where(:friend_id => current_user.id)
  end

  def create

    if !current_user.isWatcher(params[:friend_id])
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

      if @friendship.save
        redirect_to friendships_path, notice: '<strong>Well done!</strong> Watcher added.'
      else
        redirect_to friendships_path, alert: '<strong>Oh snap!</strong> Unable to add watcher.'
      end
    else
      redirect_to friendships_path, alert: '<strong>Oh snap!</strong> User is already your watcher.'
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy

    redirect_to friendships_path, notice: '<strong>Well done!</strong> Successfully removed watcher.'
  end
end
