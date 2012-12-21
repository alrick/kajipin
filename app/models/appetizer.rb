class Appetizer < ActiveRecord::Base
  # General
  def self.appname
    "Kajipin"
  end

  # Geonames config
  def self.geonames_maxrows
    "20"
  end
  def self.geonames_fuzzy
    "0.8"
  end
  def self.geonames_username
    "sloppin"
  end
  
end