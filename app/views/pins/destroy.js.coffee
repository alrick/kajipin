<% if @pin.destroyed? %>
  gon.refresh_pins() # Refresh map too
  gon.refresh_stats() # Refresh the stats at top
  gon.stop_loading()
  $("#<%= dom_id(@pin) %>").fadeOut()
<% else %>
  gon.stop_loading()
  $("#<%= dom_id(@pin) %>").fadeOut ->
    $(this).fadeIn()
<% end %>