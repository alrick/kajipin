class Comment < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  
  validates :value, :presence => true
  validates :value, :length => { :in => 2..500 }
  validates :location_id, :user_id, :numericality => { :greater_than => 0 }
end
