collection @pins_pointofinterest
attributes :id

node :geometry do |p|
  { :coordinates => [p.longitude, p.latitude] }
end

node :properties do |p|
  { :title => p.title, :subtitle => p.subtitle, :country_name => p.country_name, :country_code => p.country_code, 'marker-symbol' => p.marker_symbol, 'marker-color' => p.marker_color, 'marker-size' => p.marker_size }
end