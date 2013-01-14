<% if @comment.destroyed? %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).remove()
    if ($("#comments .comment").length < 1)
      $("#comments").html "<strong class=\"empty-set\">No comments</strong>"
<% else %>
  $("div#<%= dom_id(@comment) %>").fadeOut ->
    $(this).fadeIn()
<% end %>