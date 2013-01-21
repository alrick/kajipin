class Gallery < ActiveRecord::Base
  attr_accessible :title, :pin_id, :identifier

  belongs_to :pin

  validates :title, :identifier, :presence => true
  validates :title, :length => { :maximum => 100 }
  validates :pin_id, :numericality => { :greater_than => 0}
end
