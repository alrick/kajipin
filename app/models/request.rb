class Request < ActiveRecord::Base
  attr_accessible :user_id, :requester_id

  belongs_to :user
  belongs_to :requester, :class_name => "User"
  
  validates :user_id, :requester_id, :numericality => { :greater_than => 0}
end
