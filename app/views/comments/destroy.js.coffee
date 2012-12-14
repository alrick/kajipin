<% if @comment.destroyed? %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).remove()
    if ($("div#comments .comment").length < 1)
      $("div#comments").html "<strong>No comment</strong>"
<% else %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).fadeIn()
<% end %>