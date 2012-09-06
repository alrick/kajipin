class User < ActiveRecord::Base
  before_validation :default_values

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :terms, :birth, :sex

  has_many :locations, dependent: :destroy, :order => 'title'
  has_many :accesstokens, dependent: :destroy
  has_many :comments
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  validates :first_name, :length => { :minimum => 2 }
  validates :last_name, :length => { :minimum => 2 }
  validates :terms, :acceptance => true

  def default_values
    
  end

  def age
    if(!birth.nil?)
      age = Time.now.utc.to_date
      age.year - birth.year - ((age.month > birth.month || (age.month == birth.month && age.day >= birth.day)) ? 0 : 1)
    end
  end

  def number_locations
    locations.count
  end

  def number_countries
    locations.select("distinct(country_code)").count
  end

  def number_watchers
    friends.count
  end

  def number_sharers
    inverse_friends.count
  end

  def isWatcher(sharer_id)
    !Friendship.where(:user_id => id, :friend_id => sharer_id).empty?
  end
end
