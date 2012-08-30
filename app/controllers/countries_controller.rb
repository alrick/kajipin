require 'nokogiri'

class CountriesController < ApplicationController
  def index
    doc = Nokogiri::XML(File.open("app/data/country_info.xml"))

    @countries = doc.xpath('//country').map do |c|
      {'name' => c.xpath('countryName').inner_text, 'continent' => c.xpath('continentName').inner_text, 'capital' => c.xpath('capital').inner_text}
    end

    @countries.sort! { |a,b| a["name"] <=> b["name"] }
  end
end