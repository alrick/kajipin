collection @pins
attributes :id

node :geometry do |p|
  { :coordinates => [p.longitude, p.latitude] }
end

node :properties do |p|
  { :title => p.title, :country_name => p.country_name, :country_code => p.country_code, 'marker-symbol' => p.marker_symbol, 'marker-color' => p.marker_color, 'marker-size' => p.marker_size, :galleries_count => p.galleries_count, :logpages_count => p.logpages_count, :comments_count => p.comments_count, :locategory_hook => p.locategory_hook }
end