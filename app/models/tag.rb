class Tag < ActiveRecord::Base

  has_many :assignments, dependent: :destroy
  has_many :logpages, through: :assignments

end
