class Poi < Pin

  # Instance methods
  def fancy_name
    Poi.fancy_name
  end
  def description
    Poi.description
  end
  def marker_size
    Poi.marker_size
  end
  def marker_symbol
    Poi.marker_symbol
  end
  def marker_color
    Poi.marker_color
  end
  def get_tab
    "p"
  end
  def get_btn
    "btn-poi"
  end

  # Class methods
  def self.fancy_name
    "Point of interest"
  end
  def self.description
    "A castle, a national park or a beautiful landscape."
  end

  def self.marker_size
    "medium"
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