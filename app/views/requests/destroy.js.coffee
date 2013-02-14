<% if !@request.destroyed? %>
  $("#<%= dom_id(@request) %>").fadeOut ->
    $(this).fadeIn()
<% end %>