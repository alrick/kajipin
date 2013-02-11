<% if @request.destroyed? %>
  $("#<%= dom_id(@request) %>").fadeOut ->
    $(this).remove()
    if ($("#requests .request").length < 1)
      $("#requests").html "<p class=\"lead empty-set\">No request</p>"
<% else %>
  $("#<%= dom_id(@request) %>").fadeOut ->
    $(this).fadeIn()
<% end %>