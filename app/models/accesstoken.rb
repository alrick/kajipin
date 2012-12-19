class Accesstoken < ActiveRecord::Base
  attr_accessible :value, :user_id, :account

  belongs_to :user
  
  validates :value, :account, :type, :presence => true
  validates :user_id, :numericality => { :greater_than => 0 }
  validates :type, :uniqueness => { :scope => :user_id }
end
