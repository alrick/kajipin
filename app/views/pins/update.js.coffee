gon.stop_loading()
pin = $("#<%= dom_id(@pin) %>")

if <%= @pin.errors.empty? %>
  pin.replaceWith "<%= j(render('pins/side-pin', :pin => @pin)) %>"
  gon.change_pin_icon(<%= @pin.id %>, "<%= @pin.marker_size %>", "<%= @pin.marker_symbol %>", "<%= @pin.marker_color %>")
  gon.dec_pins_count("<%= @old_type %>")
  gon.inc_pins_count("<%= @pin.type %>")
else
  pin.find(".btn-locate").fadeOut ->
    $(this).addClass "btn-confirm"
    $(this).fadeIn ->
      $(this).fadeOut ->
        $(this).removeClass "btn-confirm"
        $(this).fadeIn()