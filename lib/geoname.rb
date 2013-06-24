class Geoname
  include HTTParty

  FUZZY = "0.8"
  BASE_URL = "http://api.geonames.org"
  SEARCH_PATH = "/searchJSON"
  GET_PATH = "/getJSON"
  FEATURES = "featureClass=H&featureClass=L&featureClass=P&featureClass=S&featureClass=T&featureClass=V"

  attr_accessor :name, :lat, :lon, :country, :country_code, :continent_code, :geoname_id, :population, :region, :type

  def initialize(name, lat, lon, country, country_code, continent_code, geoname_id, population, region, type)
    self.name = name
    self.lat = lat
    self.lon = lon
    self.country = country
    self.country_code = country_code
    self.continent_code = continent_code
    self.geoname_id = geoname_id
    self.population = population
    self.region = region
    self.type = type
  end

  def self.search(q)
    try = get(URI::escape("#{BASE_URL}#{SEARCH_PATH}?q=#{q}&fuzzy=#{FUZZY}&#{FEATURES}&username=#{ENV['GEONAMES_USERNAME']}"))
    if try.success?
      elements = Array.new
      try["geonames"].each do |e|
        elements.push self.new(e["toponymName"], e["lat"], e["lng"], e["countryName"], e["countryCode"], nil,
          e["geonameId"], e["population"], e["adminName1"], e["fclName"])
      end
      elements
    else
      raise try.response
    end
  end

  def self.find(id)
    try = get("#{BASE_URL}#{GET_PATH}", :query => {:geonameId => id, :username => ENV['GEONAMES_USERNAME']})
    if try.success?
      self.new(try["toponymName"], try["lat"], try["lng"], try["countryName"], try["countryCode"], try["continentCode"],
        try["geonameId"], try["population"], try["adminName1"], try["fclName"])
    else
      raise try.response
    end
  end

end