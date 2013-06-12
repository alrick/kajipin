<% if @pin.errors.empty? %>
  $("#<%= dom_id(@pin) %>").replaceWith "<%= j(render('pins/pin', :pin => @pin)) %>"
  gon.refresh_pins() # Refresh map too
  gon.refresh_stats() # Refresh the stats at top
<% else %>
  pin = $("#<%= dom_id(@pin) %>")
  pin.find(".dropdown-toggle").dropdown()
  pin.find(".btn-locate").fadeOut ->
    $(this).addClass "btn-confirm"
    $(this).fadeIn ->
      $(this).fadeOut ->
        $(this).removeClass "btn-confirm"
        $(this).fadeIn()
<% end %>