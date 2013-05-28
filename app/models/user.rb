class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_validation :alpha_invited? # Check if user is invited

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :terms

  has_many :pins, dependent: :destroy, :order => "title"
  has_many :comments, dependent: :nullify
  has_many :requests, dependent: :destroy
  has_many :inverse_requests, :class_name => "Request", :foreign_key => "requester_id", dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_one :avatar, dependent: :destroy
  has_one :herald, dependent: :destroy

  validates :first_name, :length => { :minimum => 2 }
  validates :last_name, :length => { :minimum => 2 }
  validates :terms, :acceptance => true

  default_scope order("first_name", "last_name")

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

  # Has this user generated an herald?
  def hasHerald?
    !herald.nil?
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

  # Get list of countries
  def visited_countries
    countries = Country.list
    visited_codes = pins.map(&:country_code).uniq
    countries.select! { |c| visited_codes.include? c["countryCode"] }
    countries.sort! { |a,b| a["name"].downcase <=> b["name"].downcase }
  end

  # Overriding confirm to add user to Madmimi
  def confirm!
    mimi = MadMimi.new(ENV["MADMIMI_EMAIL"], ENV["MADMIMI_KEY"])
    mimi.add_to_list(email, ENV["MADMIMI_LIST"])
    super
  end

  # Check if user is in alpha list
  def alpha_invited?
    unless Token.exists?(:value => email)
      errors.add :email, "is not on our alpha list"  
    end
  end 
end
