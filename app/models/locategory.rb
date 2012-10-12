class Locategory < ActiveRecord::Base
  attr_accessible :name, :description, :marker_symbol, :marker_size, :marker_color, :default

  has_many :locations

  def marker_path
    dir = "markers/"
    color = self.marker_color[1..-1]
    ext = ".png"
    marker_path = dir+self.marker_symbol+"+"+color+ext
  end
end
