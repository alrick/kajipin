class RenameFriendIdFromRequest < ActiveRecord::Migration
  def change
    rename_column :requests, :friend_id, :requester_id
  end
end
