# Calling from friendships
<% if @caller == "friendships" %>
  
  # If friend is a sharer, update the div. If not, fadeout
  <% if Friendship.exists?(:user_id => @friendship.friend_id, :friend_id => @friendship.user_id) %>
    # Reload the friend div
    $("#<%= dom_id(@friendship.friend) %>").load location.href + " #<%= dom_id(@friendship.friend) %> > *"

  <% else %>
    # The friend disapear only on friendships page
    $("#<%= dom_id(@friendship.friend) %>").fadeOut()

  <% end %>

  # Reload the sharing counter
  $("#friendships-numbersharing").html "<%= current_user.number_sharing %>"


# Calling from users page
<% elsif @caller == "users" %>

  # Reload the friend div
  $("#<%= dom_id(@friendship.friend) %>").load location.href + " #<%= dom_id(@friendship.friend) %> > *"


# Calling from map page, usermodal
<% elsif @caller == "usermodal" %>

  # Reload the sharing counter and update sharers plurialize
  $("#map-user-numbersharers").html "<%= @friendship.friend.number_sharers %>"
  $("#map-user-labelsharers").html "<%= 'Sharer'.pluralize(@friendship.friend.number_sharers) %>"

  # Reload the footer div
  $("#map-user-modalfoot").load location.href + " #map-user-modalfoot > *"
  
<% end %>