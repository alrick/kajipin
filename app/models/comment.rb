class Comment < ActiveRecord::Base
	LIMIT = 300

  attr_accessible :value, :pin_id, :user_id

  belongs_to :pin
  belongs_to :user
  
  validates :value, :length => { :in => 2..140 }
  validates :pin_id, :user_id, :numericality => { :greater_than => 0 }
  validate :check_limit, :on => :create

  private

  # Check limit isn't reached
  def check_limit
    if pin.comments.count >= LIMIT
      errors[:base] << "Comments limit reached"
    end
  end
end
