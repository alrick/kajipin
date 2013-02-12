<% if !@comment.destroyed? %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).fadeIn()
<% end %>