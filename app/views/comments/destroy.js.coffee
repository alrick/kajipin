<% if @comment.destroyed? %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).remove()
    if ($("div#comments .comment").length < 1)
      $("div#comments").html "<strong>No comments</strong>"
<% else %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).fadeIn()
<% end %>