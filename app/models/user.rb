class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name

  has_many :locations, dependent: :destroy
  has_many :accesstokens, dependent: :destroy
  has_many :comments
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships

end
