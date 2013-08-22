class Photo < Filepicker

  LIMIT = 50
  GLOBAL_LIMIT = 25000

  attr_accessible :pin_id, :url, :key, :handle, :size

  belongs_to :pin

  before_destroy :delete_remote
  
  validates :url, :format => URI::regexp(%w(https))
  validates :pin_id, :numericality => { :greater_than => 0 }
  validates :key, :handle, :presence => true
  validate :check_global_limit, :on => :create
  validate :check_limit, :on => :create

  # Pins limit getter
  def self.limit
    LIMIT
  end

  # Get url for thumbnail
  def get_mini
    width = height = 135
    fit = "crop"
    "#{url}/convert?w=#{width}&h=#{height}&fit=#{fit}"
  end

  # Get url for big
  def get_big
    width = 900
    height = 650
    fit = "max"
    "#{url}/convert?w=#{width}&h=#{height}&fit=#{fit}"
  end

  private

  # Check limit isn't reached
  def check_limit
    if pin.photos.count >= LIMIT
      errors[:base] << "Photos limit reached for this pin"
    end
  end

  # Check global limit isn't reached
  def check_global_limit
    if Photo.count >= GLOBAL_LIMIT
      errors[:base] << "Photos overloading, please contact support"
    end
  end

end