class Photo < ActiveRecord::Base
  include HTTParty # Used to access filepicker.io

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

  # Delete S3 file
  def delete_remote
    policy = get_policy("remove")
    signature = get_signature(policy)
    remote = url+"?signature="+signature+"&policy="+policy
    try = self.class.delete(remote)

    # If file not found in filepicker, destroy anyway, else only if success
    if try.not_found?
      true
    else
      try.success?
    end
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

  # Get filepicker policy
  def get_policy(call)
    if !["pick", "read", "stat", "write", "writeUrl", "store", "convert", "remove"].include? call
      raise "Incorrect call"
    else
      expiry = Time.now.to_i + 60*60
      json_policy = {:call => call, :handle => handle, :expiry => expiry}.to_json
      policy = Base64.urlsafe_encode64(json_policy)
    end
  end

  # Get filepicker signature
  def get_signature(policy)
    secret = ENV["FILEPICKER_SECRET"]
    signature = OpenSSL::HMAC.hexdigest("sha256", secret, policy)
  end

end
