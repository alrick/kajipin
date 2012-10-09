object @pin
attributes :id

node :geometry do |p|
  { :coordinates => [p.latitude, p.longitude] }
end

node :properties do |p|
  { :title => p.title, :subtitle => p.subtitle, :country_name => p.country_name, :country_code => p.country_code }
end