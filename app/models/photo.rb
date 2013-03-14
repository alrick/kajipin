class Photo < ActiveRecord::Base
  LIMIT = 3

  attr_accessible :pin_id, :url

  belongs_to :pin
  
  validates :url, :format => URI::regexp(%w(https))
  validates :pin_id, :numericality => { :greater_than => 0 }

  validates_each :pin do |photo, attr, value|
    photo.errors.add attr, "You've reached your photos limit for this pin" if photo.pin.photos.size >= LIMIT
  end

  # Pins limit getter
  def self.limit
    LIMIT
  end
end
