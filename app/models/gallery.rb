class Gallery < ActiveRecord::Base
  belongs_to :location
  
  validates :name, :presence => true
  validates :name, :length => { :maximum => 100 }
  validates :location_id, :numericality => { :greater_than => 0}
end
