class Accesstoken < ActiveRecord::Base
  attr_accessible :value, :account, :user_id

  belongs_to :user
  
  validates :token, :account, :secret, :presence => true
  validates :user_id, :numericality => { :greater_than => 0 }
  validates :user_id, :uniqueness => true
end
