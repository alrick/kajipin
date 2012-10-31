require 'nokogiri'

class GeoController < ApplicationController
  
  # Get a list of all countries from geonames
  def get_countries
    doc = Nokogiri::XML(File.open("app/data/country_info.xml"))

    @countries = doc.xpath("//country").map do |c|
      {
        "name" => c.xpath("countryName").inner_text,
        "continent" => c.xpath("continentName").inner_text,
        "capital" => c.xpath("capital").inner_text,
        "west" => c.xpath("west").inner_text,
        "east" => c.xpath("east").inner_text,
        "north" => c.xpath("north").inner_text,
        "south" => c.xpath("south").inner_text
      }
    end

    @countries.sort! { |a,b| a["name"] <=> b["name"] }
  end
end