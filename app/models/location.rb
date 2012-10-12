class Location < ActiveRecord::Base
  attr_accessible :title, :subtitle, :user_id, :latitude, :longitude, :locategory_id

  belongs_to :user
  belongs_to :locategory
  has_many :comments, dependent: :destroy
  has_one :logbook, dependent: :destroy
  has_many :galleries, dependent: :destroy

  validates :title, :country_name, :country_code, :presence => true
  validates :latitude, :longitude, :numericality => true
  validates :subtitle, :length => { :in => 2..100 }, :allow_blank => true
  validates :user_id, :locategory_id, :numericality => { :greater_than => 0}

  def short_lat
    '%.3f' % latitude
  end

  def short_lon
    '%.3f' % longitude
  end

  def galleries_count
    galleries.count.to_s
  end

  def logpages_count
    '0'
  end

  def comments_count
    comments.count.to_s
  end

  def marker_size
    self.locategory.marker_size
  end

  def marker_symbol
    self.locategory.marker_symbol
  end

  def marker_color
    self.locategory.marker_color
  end
end
