<% if @logpage.destroyed? %>
  $("#<%= dom_id(@logpage) %>").fadeOut ->
    $(this).remove()

<% else %>
  $("#<%= dom_id(@logpage) %>").fadeOut ->
    $(this).fadeIn()
<% end %>