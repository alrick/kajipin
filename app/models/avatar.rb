class Avatar < ActiveRecord::Base
  attr_accessible :handle, :key, :size, :url, :user_id

  belongs_to :user
end
