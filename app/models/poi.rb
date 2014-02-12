class Poi < Pin

  # Instance methods
  def marker_size
    Poi.marker_size
  end
  def marker_symbol
    Poi.marker_symbol
  end
  def marker_color
    Poi.marker_color
  end
  def get_btn
    "btn-poi"
  end

  # Class methods
  def self.marker_size
    "large"
  end
  def self.marker_symbol
    "star"
  end
  def self.marker_color
    "#7FA4B1"
  end
  def self.marker_path
    dir ="markers/"
    color = Poi.marker_color[1..-1]
    symbol = Poi.marker_symbol
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end
end