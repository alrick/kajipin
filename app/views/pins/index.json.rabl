collection @pins
attributes :id

node :type do
  "Feature"
end

node :geometry do |p|
  { 
    :type => "Point",
    :coordinates => [p.longitude, p.latitude]
  }
end

node :properties do |p|
  { 
    :title => p.title, 
    :country_name => p.country_name,
    :country_code => p.country_code,
    :type => p.type,
    'marker-symbol' => p.marker_symbol,
    'marker-color' => p.marker_color,
    'marker-size' => p.marker_size,
    :photos_count => p.photos.count,
    :comments_count => p.comments.count
  }
end