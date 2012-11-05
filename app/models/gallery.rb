class Gallery < ActiveRecord::Base
  attr_accessible :name, :pin_id

  belongs_to :pin

  validates :name, :presence => true
  validates :name, :length => { :maximum => 100 }
  validates :pin_id, :numericality => { :greater_than => 0}
end
