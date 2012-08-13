object @location
attributes :id, :title, :subtitle, :country_name, :country_code, :latitude, :longitude

child :user do
  attributes :first_name, :last_name
end