gon.stop_loading()

if <%= @pin.destroyed? %>
	if "<%= @pin.type %>" == "<%= City.sti_name %>"
		gon.dec_cities_count()
	else if "<%= @pin.type %>" == "<%= Town.sti_name %>"
		gon.dec_towns_count()
	else if "<%= @pin.type %>" == "<%= Poi.sti_name %>"
		gon.dec_pois_count()
	$("#<%= dom_id(@pin) %>").fadeOut()
	gon.remove_pin(<%= @pin.id %>)
else
	$("#<%= dom_id(@pin) %>").fadeOut ->
  	$(this).fadeIn()