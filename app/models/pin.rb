class Pin < ActiveRecord::Base
  LIMIT = 50
  HIGH_POPULATED_LIMIT = 10

  attr_accessible :title, :user_id, :latitude, :longitude, :country_name, :country_code, :continent_code, :ext_id, :population, :type

  belongs_to :user
  has_many :photos, dependent: :destroy, :order => "created_at ASC"
  has_many :comments, dependent: :destroy, :order => "created_at ASC"

  before_validation :init_datas

  validates :title, :country_name, :country_code, :continent_code, :type, :presence => true
  validates :latitude, :longitude, :numericality => true
  validates :user_id, :ext_id, :numericality => { :greater_than => 0}
  validates :user_id, :uniqueness => { :scope => [:latitude, :longitude],
    :message => "Pins can't have same latitude and longitude" }
  validates :type, :inclusion => { :in => %w(City Town Poi),
    :message => "%{value} is not a valid type" }
  validate :check_limit, :on => :create

  scope :city, where(:type => "City")
  scope :town, where(:type => "Town")
  scope :poi, where(:type => "Poi")

  def initialize(attributes = {})
    super
  end

  # Fix problem with child path in sti
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Pin.model_name
      end
    end
    super
  end

  # Pins limit getter
  def self.limit
    LIMIT
  end

  private

  def init_datas
    geoname = Geoname.find(ext_id)
    self.title = geoname.name
    self.latitude = geoname.lat
    self.longitude = geoname.lon
    self.country_name = geoname.country
    self.country_code = geoname.country_code
    self.continent_code = geoname.continent_code
    self.ext_id = geoname.geoname_id
    self.population = geoname.population
  end

  # Check limit isn't reached
  def check_limit
    if user.pins.count >= LIMIT
      errors[:base] << "Pins limit reached"
    end
  end

end
