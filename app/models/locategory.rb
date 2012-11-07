class Locategory < ActiveRecord::Base
  attr_accessible :name, :description, :marker_symbol, :marker_size, :marker_color, :default, :hook

  has_many :pins

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

  def self.bigcity_hook
    1
  end

  def self.smallcity_hook
    2
  end

  def self.pointofinterest_hook
    3
  end

  # Get right tab in terms of locategory
  def get_tab
    if(hook == Locategory.smallcity_hook)
      tab = "s"
    elsif (hook == Locategory.pointofinterest_hook)
      tab = "p"
    else
      tab = "b"
    end
    return tab
  end
end