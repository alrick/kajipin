<% if @friendship.new_record? %>

  # Fade out and in to report an error
  $("#<%= dom_id(@friendship.friend) %>").fadeOut ->
    $(this).fadeIn()
      
<% else %>

  # Load element containing sharing button
  container = $("#<%= dom_id(@friendship.friend) %>")

  # Reload the friend div and add the hoverIntent effect to the btn
  container.load location.href + " #<%= dom_id(@friendship.friend) %> > *", ->
    container.find(".btn-social").hoverIntent (->
      $(this).html("Unshare").addClass "btn-remove"
    ), ->
      $(this).html("<i class=\"icon-heart\"></i>&nbsp;Sharing").removeClass "btn-remove"

  # Update counter if present
  $("#sharing-counter").html "<%= @friendship.user.number_sharing %>" if $("#sharing-counter").length

<% end %>