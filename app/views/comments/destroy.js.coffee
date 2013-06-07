<% if @comment.destroyed? %>
  $("#<%= dom_id(@comment) %>").fadeOut()
<% else %>
  $("#<%= dom_id(@comment) %>").fadeOut ->
    $(this).fadeIn()
<% end %>