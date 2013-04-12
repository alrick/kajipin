collection @pins
attributes :id

node :geometry do |p|
  { :coordinates => [p.longitude, p.latitude] }
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
    'photos_path' => pin_photos_path(p),
    'comments_path' => pin_comments_path(p),
    'logpages_path' => pin_logpages_path(p),
    :type => p.type
  }
end