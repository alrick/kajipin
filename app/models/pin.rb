class Pin < ActiveRecord::Base
  LIMIT = 50
  HIGH_POPULATED_LIMIT = 10

  attr_accessible :title, :user_id, :latitude, :longitude, :country_name, :country_code, :continent_code, :ext_id, :population, :type

  belongs_to :user
  has_many :photos, dependent: :destroy, :order => "created_at ASC"
  has_many :comments, dependent: :destroy, :order => "created_at ASC"
  has_many :logpages, dependent: :destroy, :order => "created_at ASC"

  validates :title, :country_name, :country_code, :continent_code, :type, :presence => true
  validates :latitude, :longitude, :numericality => true
  validates :user_id, :ext_id, :numericality => { :greater_than => 0}

  validates :user_id, :uniqueness => { :scope => [:latitude, :longitude], :message => "Your pin can't have same latitude and longitude than another pin" }

  validates_each :user do |pin, attr, value|
    pin.errors.add attr, "You've reached your pins limit" if pin.user.pins.size >= LIMIT
    pin.errors.add attr, "You've reached your high populated pins limit" if pin.high_populated? && pin.user.pins.high_populated.size >= HIGH_POPULATED_LIMIT
  end

  scope :bigcity, where(:type => "Bigcity")
  scope :smallcity, where(:type => "Smallcity")
  scope :poi, where(:type => "Poi")
  scope :high_populated, where("population >= 1000000")

  # Fix problem with child path in sti
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Pin.model_name
      end
    end
    super
  end

  def short_lat
    "%.3f" % latitude
  end

  def short_lon
    "%.3f" % longitude
  end

  def photos_count
    photos.count.to_s.html_safe
  end

  def logpages_count
    logpages.count.to_s.html_safe
  end

  def comments_count
    comments.count.to_s.html_safe
  end

  def normalized
    title.gsub(/[^0-9A-Za-z]/, '') + "-" + id.to_s
  end

  # Check if pin is a high populated
  def high_populated?
    if population >= 1000000
      return true
    else
      return false
    end
  end

  # Pins limit getter
  def self.limit
    LIMIT
  end

  # High populated limit getter
  def self.high_populated_limit
    HIGH_POPULATED_LIMIT
  end

end
