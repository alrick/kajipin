class Geonamesconfig < ActiveRecord::Base
  def self.maxrows
    "15"
  end
  def self.fuzzy
    "0.8"
  end
  def self.username
    "sloppin"
  end
end