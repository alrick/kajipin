class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :terms

  has_many :locations, dependent: :destroy
  has_many :accesstokens, dependent: :destroy
  has_many :comments
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships

  validates :first_name, :length => { :minimum => 2 }
  validates :last_name, :length => { :minimum => 2 }
  validates :terms, :acceptance => true
end
