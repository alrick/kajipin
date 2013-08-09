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
    :comments_count => p.comments.count,
    'photos_path' => pin_photos_path(p),
    'comments_path' => pin_comments_path(p),
    :type => p.type
  }
end

child :photos, :object_root => false do
  attributes :id, :get_mini, :get_big
end

child :comments, :object_root => false do
  attributes :value, :created_at
  child :user do
    attributes :full_name
  end
end