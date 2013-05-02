class Bigcity < Pin

  # Instance methods
  def fancy_name
    Bigcity.fancy_name
  end
  def description
    Bigcity.description
  end
  def marker_size
    Bigcity.marker_size
  end
  def marker_symbol
    Bigcity.marker_symbol
  end
  def marker_color
    Bigcity.marker_color
  end
  def get_tab
    "b"
  end
  def get_btn
    "btn-city"
  end

  # Class methods
  def self.fancy_name
    "Big city"
  end
  def self.description
    "This is a big city for you!"
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
    dir ="markers/"
    color = Bigcity.marker_color[1..-1]
    symbol = Bigcity.marker_symbol
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end
end