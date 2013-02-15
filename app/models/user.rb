class User < ActiveRecord::Base

  MADMIMI_EMAIL = "hey@kajipin.com"
  MADMIMI_KEY = "d0de3647f7d78cd634e43e716bb6d531"
  MADMIMI_LIST = "Registered"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :terms, :birth, :sex

  has_many :pins, dependent: :destroy, :order => "title"
  has_many :comments, dependent: :nullify
  has_many :requests, dependent: :destroy
  has_many :inverse_requests, :class_name => "Request", :foreign_key => "requester_id", dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  validates :first_name, :length => { :minimum => 2 }
  validates :last_name, :length => { :minimum => 2 }
  validates :terms, :acceptance => true

  default_scope order("first_name", "last_name")

  def age
    if(!birth.nil?)
      age = Time.now.utc.to_date
      age.year - birth.year - ((age.month > birth.month || (age.month == birth.month && age.day >= birth.day)) ? 0 : 1)
    end
  end

  def full_name
    first_name+" "+last_name
  end

  def number_pins
    pins.count
  end

  def number_countries
    pins.select("distinct(country_code)").count
  end

  def number_continents
    pins.select("distinct(continent_code)").count
  end

  def number_sharing
    friends.count
  end

  def number_sharers
    inverse_friends.count
  end

  # Has this user some requests pending?
  def hasRequest?
    !requests.empty?
  end

  # Is this user is sharing with user passed?
  def isSharingWith(user)
    friends.where(:id => user.id).exists?
  end

  # Search func for users
  def self.search(q)
    if q
      find(:all, :conditions => ["lower(first_name) LIKE ? or lower(last_name) LIKE ? or concat(lower(first_name), ' ', lower(last_name)) LIKE ?", "%#{q.downcase}%", "%#{q.downcase}%", "%#{q.downcase}%"])
    else
      find(:all)
    end
  end

  # Overriding confirm to add user to Madmimi
  def confirm!
    mimi = MadMimi.new(MADMIMI_EMAIL, MADMIMI_KEY)
    mimi.add_to_list(email, MADMIMI_LIST)
    super
  end
end
