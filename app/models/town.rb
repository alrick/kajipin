class Town < Pin

  # Instance methods
  def marker_size
    Town.marker_size
  end
  def marker_symbol
    Town.marker_symbol
  end
  def marker_color
    Town.marker_color
  end
  def get_tab
    "s"
  end
  def get_btn
    "btn-town"
  end

  # Class methods
  def self.marker_size
    "medium"
  end
  def self.marker_symbol
    "town-hall"
  end
  def self.marker_color
    "#887D75"
  end
  def self.marker_path
    dir ="markers/"
    color = Town.marker_color[1..-1]
    symbol = Town.marker_symbol
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end
end