class Fly < Pin

  # Instance methods
  def marker_size
    Fly.marker_size
  end
  def marker_symbol
    Fly.marker_symbol
  end
  def marker_color
    Fly.marker_color
  end
  def get_btn
    "btn-fly"
  end

  # Class methods
  def self.marker_size
    "medium"
  end
  def self.marker_symbol
    "airport"
  end
  def self.marker_color
    "#701516"
  end
  def self.marker_path
    dir ="markers/"
    color = Fly.marker_color[1..-1]
    symbol = Fly.marker_symbol
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end
end