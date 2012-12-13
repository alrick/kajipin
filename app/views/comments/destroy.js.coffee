<% if @comment.destroyed? %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).remove()

  if ($("div#comments .comment").length <= 1)
    $("div#comments").append("<strong>No comment</strong>")
<% else %>
  $("div#<%= dom_id(@comment) %>").effect("highlight", { color: "#5F1818" })
<% end %>