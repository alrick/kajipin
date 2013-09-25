<% if @comment.destroyed? %>
  $("#<%= dom_id(@comment) %>").fadeOut()
  gon.update_comments(<%= @comment.pin.id %>, <%= @comment.pin.comments.count %>)
<% else %>
  $("#<%= dom_id(@comment) %>").fadeOut ->
    $(this).fadeIn()
<% end %>