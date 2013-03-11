class Photo < ActiveRecord::Base
  attr_accessible :pin_id, :url

  belongs_to :pin
  
  validates :url, :format => URI::regexp(%w(https))
  validates :pin_id, :numericality => { :greater_than => 0 }
end
