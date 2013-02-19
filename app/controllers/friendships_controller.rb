class FriendshipsController < ApplicationController 
  # Devise authentication
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource

  # Delete related requests
  after_filter :remove_request, :only => :create

  def index
    sharings = current_user.friends
    sharers = current_user.inverse_friends
    @empty = (sharings+sharers).uniq.sort_by(&:first_name).empty?
    if params[:filter] == "sharing"
      bmates = sharings
      @filter = "sharing"
    elsif params[:filter] == "sharers"
      bmates = sharers
      @filter = "sharers"
    else
      bmates = (sharings+sharers).uniq.sort_by(&:first_name)
      @filter = "both"
    end
    @mates = Kaminari.paginate_array(bmates).page(params[:page]).per(20)
  end

  def create
    friend = User.find(params[:friend])
    @friendship = Friendship.new
    @friendship.user_id = current_user.id
    @friendship.friend_id = friend.id
    @friendship.save

    if params[:page] == "user"
      redirect_to modal_user_url(friend)
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy

    if params[:page] == "user"
      redirect_to modal_user_url(@friendship.friend)
    else
      respond_to do |format|
        format.js
      end
    end
  end

  # When a friendship is created, delete eventual related requests
  def remove_request
    if Request.exists?(:user_id => @friendship.user_id, :requester_id => @friendship.friend_id) && !@friendship.new_record?
      Request.where(:user_id => @friendship.user_id, :requester_id => @friendship.friend_id).delete_all
    end
  end
end
