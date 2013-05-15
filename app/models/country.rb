class Country

  def self.list
    doc = Nokogiri::XML(File.open("app/data/country_info.xml"))

    list = doc.xpath("//country").map do |c|
      {
        "name" => c.xpath("countryName").inner_text,
        "continent" => c.xpath("continentName").inner_text,
        "capital" => c.xpath("capital").inner_text,
        "west" => c.xpath("west").inner_text,
        "east" => c.xpath("east").inner_text,
        "north" => c.xpath("north").inner_text,
        "south" => c.xpath("south").inner_text,
        "countryCode" => c.xpath("countryCode").inner_text
      }
    end

    list.sort! { |a,b| a["name"].downcase <=> b["name"].downcase }
  end
end
