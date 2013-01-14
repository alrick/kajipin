<% if @pin.destroyed? %>
  $("#<%= dom_id(@pin) %>").fadeOut ->
    tabpane = $(this).closest('.tab-pane')
    $(this).remove()
    if $("#pins tr[data-locategory='<%= @pin.locategory_id %>']").length < 1
      tabpane.html "<p class=\"lead empty-set\">No pin added.</p>"

<% else %>
  $("#<%= dom_id(@pin) %>").fadeOut ->
    $(this).fadeIn()
<% end %>