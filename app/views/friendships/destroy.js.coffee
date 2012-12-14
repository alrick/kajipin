<% if @friendship.destroyed? %>
  # Calling from friendships
  if $("#friendships").length > 0

    # If friend is a sharer, update the div
    if $("#<%= dom_id(@friendship.friend) %> .is-sharer").length > 0
      # Reload the friend div
      $("#<%= dom_id(@friendship.friend) %>").load location.href + " #<%= dom_id(@friendship.friend) %> > *"
      # Reload the sharing counter
      $("#friendships-numbersharing").html "<%= @friendship.user.number_sharing %>"

    # If not, fadeout
    else
      # The friend disapear only on friendships page
      $("#<%= dom_id(@friendship.friend) %>").fadeOut ->
        $(this).remove()
        if $("#friendships .userbox").length < 1
          $("#friendships").html "<p class=\"lead\">No user found.</p>"
      # Reload the sharing counter
      $("#friendships-numbersharing").html "<%= @friendship.user.number_sharing %>"

  # Calling from users page
  else if $("#users").length > 0

    # Reload the friend div
    $("#<%= dom_id(@friendship.friend) %>").load location.href + " #<%= dom_id(@friendship.friend) %> > *"

  # Calling from map page, usermodal
  else if $("#userModal").length > 0

    # Reload the sharing counter and update sharers plurialize
    $("#map-user-numbersharers").html "<%= @friendship.friend.number_sharers %>"
    $("#map-user-labelsharers").html "<%= 'Sharer'.pluralize(@friendship.friend.number_sharers) %>"

    # Reload the footer div
    $("#map-user-modalfoot").load location.href + " #map-user-modalfoot > *"

<% else %>
  if $("#friendships").length > 0 || $("#users").length > 0
    $("#<%= dom_id(@friendship.friend) %>").fadeOut ->
      $(this).fadeIn()
  else
    $("#userModal .btn-social").fadeOut ->
      $(this).fadeIn()
<% end %>