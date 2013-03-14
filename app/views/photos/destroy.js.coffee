<% if @photo.destroyed? %>
  $("#<%= dom_id(@photo) %>").fadeOut()
<% else %>
  $("#<%= dom_id(@photo) %>").fadeOut ->
    $(this).fadeIn()
<% end %>