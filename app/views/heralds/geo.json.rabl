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
    :photos_count => p.photos.count,
    :logpages_count => p.logpages.count,
    :comments_count => p.comments.count,
    'photos_path' => photos_heralds_path(:key => @herald.key, :pin => p),
    'comments_path' => comments_heralds_path(:key => @herald.key, :pin => p),
    'logpages_path' => logpages_heralds_path(:key => @herald.key, :pin => p),
    :type => p.type
  }
end