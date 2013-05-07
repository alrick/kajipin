class City < Pin

  # Instance methods
  def fancy_name
    City.fancy_name
  end
  def description
    City.description
  end
  def marker_size
    City.marker_size
  end
  def marker_symbol
    City.marker_symbol
  end
  def marker_color
    City.marker_color
  end
  def get_tab
    "b"
  end
  def get_btn
    "btn-city"
  end

  # Class methods
  def self.fancy_name
    "City"
  end
  def self.marker_size
    "large"
  end
  def self.marker_symbol
    "town-hall"
  end
  def self.marker_color
    "#4b4658"
  end
  def self.marker_path
    dir = "markers/"
    color = City.marker_color[1..-1]
    symbol = City.marker_symbol
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end
end