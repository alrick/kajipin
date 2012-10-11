class Locategory < ActiveRecord::Base
  attr_accessible :name, :description, :marker_symbol, :marker_size, :marker_color

  has_many :locations
end
