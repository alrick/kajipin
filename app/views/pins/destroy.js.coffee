<% if @pin.destroyed? %>
  $("#<%= dom_id(@pin) %>").fadeOut()
  gon.refresh_pins() # Refresh map too
  gon.refresh_stats() # Refresh the stats at top
<% else %>
  $("#<%= dom_id(@pin) %>").fadeOut ->
    $(this).fadeIn()
<% end %>