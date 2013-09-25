gon.loading(false)
pin = $("#<%= dom_id(@pin) %>")

if <%= @pin.errors.empty? %>
  gon.pinMap[<%= @pin.id %>].closePopup()
  pin.find(".icon-map-marker").removeClass("<%= pin_class(@old_type) %>").addClass("<%= pin_class(@pin.type) %>")
  gon.change_pin_icon(<%= @pin.id %>, "<%= @pin.marker_size %>", "<%= @pin.marker_symbol %>", "<%= @pin.marker_color %>")
  gon.dec_pins_count("<%= @old_type %>")
  gon.inc_pins_count("<%= @pin.type %>")