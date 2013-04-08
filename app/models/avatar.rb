class Avatar < Filepicker
  attr_accessible :handle, :key, :size, :url, :user_id

  belongs_to :user

  before_destroy :delete_remote

  validates :url, :format => URI::regexp(%w(https))
  validates :user_id, :numericality => { :greater_than => 0 }
  validates :key, :handle, :presence => true

end