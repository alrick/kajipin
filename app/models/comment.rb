class Comment < ActiveRecord::Base
  attr_accessible :value, :pin_id, :user_id

  belongs_to :pin
  belongs_to :user
  
  validates :value, :length => { :in => 2..140 }
  validates :pin_id, :user_id, :numericality => { :greater_than => 0 }

  def date
  	created_at.to_formatted_s(:long_ordinal)
  end
end
