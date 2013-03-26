class Photo < ActiveRecord::Base
  include HTTParty # Used to access filepicker.io

  LIMIT = 50

  attr_accessible :pin_id, :url

  belongs_to :pin

  before_destroy :delete_s3
  
  validates :url, :format => URI::regexp(%w(https))
  validates :pin_id, :numericality => { :greater_than => 0 }

  validates_each :pin do |photo, attr, value|
    photo.errors.add attr, "you've reached your photos limit for this pin" if photo.pin.photos.size >= LIMIT
  end

  # Pins limit getter
  def self.limit
    LIMIT
  end

  # Delete S3 file
  def delete_s3
    try = self.class.delete(url)
    try.success?
  end

end
