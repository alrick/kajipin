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
    $("#userModal #number-sharers").html "<%= @friendship.friend.number_sharers %>"
    $("#userModal #label-sharers").html "<%= 'Sharer'.pluralize(@friendship.friend.number_sharers) %>"

    # Reload the footer div and add the hoverIntent effect to the btn
    $("#userModal .modal-footer").load location.href + " #userModal .modal-footer > *", ->
      $("#userModal .modal-footer a.btn-social").hoverIntent (->
        $(this).html("Unshare").addClass "btn-remove"
      ), ->
        $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass "btn-remove"
<% end %>