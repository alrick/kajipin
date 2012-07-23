class Logbook < ActiveRecord::Base
  belongs_to :location
  has_many :logpages, dependent: :destroy

  validates :description, :length => { :minimum => 2 }, :allow_blank => true
  validates :location_id, :numericality => { :greater_than => 0}
end