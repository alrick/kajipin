<% if @pin.destroyed? %>
  $("#<%= dom_id(@pin) %>").fadeOut()
<% else %>
  $("#<%= dom_id(@pin) %>").fadeOut ->
    $(this).fadeIn()
<% end %>