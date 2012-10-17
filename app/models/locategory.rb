class Locategory < ActiveRecord::Base
  attr_accessible :name, :description, :marker_symbol, :marker_size, :marker_color, :default

  has_many :locations

  def marker_path
    dir = "markers/"
    color = self.marker_color[1..-1]
    symbol = self.marker_symbol
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end

  def self.bigcity_marker_path
    dir = "markers/"
    color = "4A4459"
    symbol = "town-hall"
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end

  def self.smallcity_marker_path
    dir = "markers/"
    color = "887D75"
    symbol = "town-hall"
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end

  def self.pointofinterest_marker_path
    dir = "markers/"
    color = "7FA4B1"
    symbol = "star"
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end
end
