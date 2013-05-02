class Smallcity < Pin

  # Instance methods
  def fancy_name
    Smallcity.fancy_name
  end
  def description
    Smallcity.description
  end
  def marker_size
    Smallcity.marker_size
  end
  def marker_symbol
    Smallcity.marker_symbol
  end
  def marker_color
    Smallcity.marker_color
  end
  def get_tab
    "s"
  end
  def get_btn
    "btn-town"
  end

  # Class methods
  def self.fancy_name
    "Small city"
  end
  def self.description
    "A less famous city."
  end
  def self.marker_size
    "medium"
  end
  def self.marker_symbol
    "warehouse"
  end
  def self.marker_color
    "#887D75"
  end
  def self.marker_path
    dir ="markers/"
    color = Smallcity.marker_color[1..-1]
    symbol = Smallcity.marker_symbol
    ext = ".png"
    marker_path = dir+symbol+"+"+color+ext
  end
end