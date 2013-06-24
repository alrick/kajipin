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
  validates :user_id, :uniqueness => { :scope => [:latitude, :longitude],
    :message => "Pins can't have same latitude and longitude" }
  validates :type, :inclusion => { :in => %w(City Town Poi),
    :message => "%{value} is not a valid type" }
  validate :check_limit, :on => :create
  validate :check_high_populated_limit, :on => :create

  scope :city, where(:type => "City")
  scope :town, where(:type => "Town")
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

  private

  # Check limit isn't reached
  def check_limit
    if user.pins.count >= LIMIT
      errors[:base] << "Pins limit reached"
    end
  end

  # Check high populated limit isn't reached
  def check_high_populated_limit
    if high_populated? && user.pins.high_populated.count >= HIGH_POPULATED_LIMIT
      errors[:base] << "High populated limit reached"
    end
  end

  # Init a pin with geodata
  def init(geoname_id, user_id)
    geoname = Geoname.find(geoname_id)
    user_id = user_id
    title = geoname.name
    latitude = geoname.lat
    longitude = geoname.lon
    country_name = geoname.country
    country_code = geoname.country_code
    continent_code = geoname.continent_code
    ext_id = geoname.geoname_id
    population = geoname.population
  end

end
