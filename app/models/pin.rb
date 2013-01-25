class Pin < ActiveRecord::Base
  attr_accessible :title, :user_id, :latitude, :longitude, :locategory_id

  belongs_to :user
  belongs_to :locategory
  has_many :comments, dependent: :destroy, :order => "created_at ASC"
  has_many :galleries, dependent: :destroy, :order => "title"
  has_many :logpages, dependent: :destroy, :order => "created_at ASC"

  validates :title, :country_name, :country_code, :presence => true
  validates :latitude, :longitude, :numericality => true
  validates :user_id, :locategory_id, :ext_id, :numericality => { :greater_than => 0}

  scope :bigcity, joins(:locategory).where("locategories.hook=1")
  scope :smallcity, joins(:locategory).where("locategories.hook=2")
  scope :pointofinterest, joins(:locategory).where("locategories.hook=3")

  def short_lat
    "%.3f" % latitude
  end

  def short_lon
    "%.3f" % longitude
  end

  def galleries_count
    galleries.count.to_s.html_safe
  end

  def logpages_count
    logpages.count.to_s.html_safe
  end

  def comments_count
    comments.count.to_s.html_safe
  end

  def marker_size
    locategory.marker_size
  end

  def marker_symbol
    locategory.marker_symbol
  end

  def marker_color
    locategory.marker_color
  end

  def locategory_hook
    locategory.hook
  end

  def normalized
    title.gsub(/[^0-9A-Za-z]/, '') + "-" + id.to_s
  end

end
