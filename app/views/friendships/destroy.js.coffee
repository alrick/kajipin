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
      # Reload the sharing counter
      $("#friendships-numbersharing").html "<%= @friendship.user.number_sharing %>"

  # Calling from users page
  else if $("#users").length > 0

    # Reload the friend div
    $("#<%= dom_id(@friendship.friend) %>").load location.href + " #<%= dom_id(@friendship.friend) %> > *"

<% else %>
  $("#<%= dom_id(@friendship.friend) %>").fadeOut ->
    $(this).fadeIn()
<% end %>