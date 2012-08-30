class Friendship < ActiveRecord::Base
  attr_accessible :user_id, :friend_id

  belongs_to :user
  belongs_to :friend, :class_name => "User"
  
  validates :user_id, :friend_id, :numericality => { :greater_than => 0}
end
