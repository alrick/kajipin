class Comment < ActiveRecord::Base
  attr_accessible :value, :location_id, :user_id

  belongs_to :location
  belongs_to :user
  
  validates :value, :length => { :in => 2..140 }
  validates :location_id, :user_id, :numericality => { :greater_than => 0 }
end
