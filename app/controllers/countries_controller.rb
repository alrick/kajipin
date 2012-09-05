require 'nokogiri'

class CountriesController < GeoController
  def index
    get_countries
  end
end