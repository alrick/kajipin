class Photo < ActiveRecord::Base
  include HTTParty # Used to access filepicker.io

  LIMIT = 50

  attr_accessible :pin_id, :url

  belongs_to :pin

  before_destroy :delete_remote
  
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
  def delete_remote
    try = self.class.delete(url)

    # If file not found in filepicker, destroy anyway, else only if success
    if try.not_found?
      return true
    else
      return try.success?
    end
  end

end
