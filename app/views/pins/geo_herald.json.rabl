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
    'marker-symbol' => p.marker_symbol,
    'marker-color' => p.marker_color,
    'marker-size' => p.marker_size,
    :photos_count => p.photos_count,
    :logpages_count => p.logpages_count,
    :comments_count => p.comments_count,
    'photos_path' => photos_herald_path(@herald, :pin => p),
    'comments_path' => pin_comments_path(p),
    'logpages_path' => logpages_herald_path(@herald, :pin => p),
    :type => p.type
  }
end