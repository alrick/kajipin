class Accesstoken < ActiveRecord::Base
  attr_accessible :value, :account, :user_id, :uid, :token, :secret

  belongs_to :user
  has_many :galleries, dependent: :destroy
  
  validates :token, :account, :secret, :presence => true
  validates :user_id, :uid, :numericality => { :greater_than => 0 }
  validates :user_id, :uniqueness => true
  validates :uid, :uniqueness => true
end
