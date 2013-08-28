class Comment < ActiveRecord::Base
  attr_accessible :value, :pin_id, :user_id

  belongs_to :pin
  belongs_to :user
  
  validates :value, :length => { :in => 2..140 }
  validates :pin_id, :user_id, :numericality => { :greater_than => 0 }
end
