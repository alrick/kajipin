class Herald < ActiveRecord::Base
  attr_accessible :key, :user_id

  belongs_to :user
end
