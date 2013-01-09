<% if @logpage.destroyed? %>
  $("#<%= dom_id(@logpage) %>").fadeOut ->
    $(this).remove()
    if $(".logpage").length < 1
      $("#logpages").html "<p class=\"lead\">You have not yet added pages.</p>"

<% else %>
  $("#<%= dom_id(@logpage) %>").fadeOut ->
    $(this).fadeIn()
<% end %>