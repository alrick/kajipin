<% if @friendship.new_record? %>
  # Calling from friendships or users page
  if $("#friendships").length > 0 || $("#users").length > 0
    $("#<%= dom_id(@friendship.friend) %>").fadeOut ->
      $(this).fadeIn()

  # Calling from map page, usermodal
  else if $("#userModal").length > 0
    $("#userModal .btn-social").fadeOut ->
      $(this).fadeIn()
      
<% else %>
  # Calling from friendships or users page
  if $("#friendships").length > 0 || $("#users").length > 0

    # Reload the friend div and add the hoverIntent effect to the btn
    $("#<%= dom_id(@friendship.friend) %>").load location.href + " #<%= dom_id(@friendship.friend) %> > *", ->
      $("#<%= dom_id(@friendship.friend) %> a.btn-social").hoverIntent (->
        $(this).html("Unshare").addClass "btn-remove"
      ), ->
        $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass "btn-remove"

    # Reload the sharing counter
    $("#friendships-numbersharing").html "<%= current_user.number_sharing %>"


  # Calling from map page, usermodal
  else if $("#userModal").length > 0

    # Reload the sharing counter and update sharers plurialize
    $("#map-user-numbersharers").html "<%= @friendship.friend.number_sharers %>"
    $("#map-user-labelsharers").html "<%= 'Sharer'.pluralize(@friendship.friend.number_sharers) %>"

    # Reload the footer div and add the hoverIntent effect to the btn
    $("#map-user-modalfoot").load location.href + " #map-user-modalfoot > *", ->
      $("#map-user-modalfoot a.btn-social").hoverIntent (->
        $(this).html("Unshare").addClass "btn-remove"
      ), ->
        $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass "btn-remove"
<% end %>