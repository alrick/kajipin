gon.loading(false)
pin = $("#<%= dom_id(@pin) %>")

if <%= @pin.destroyed? %>
	gon.dec_pins_count("<%= @pin.type %>")
	pin.fadeOut()
	gon.remove_pin(<%= @pin.id %>)