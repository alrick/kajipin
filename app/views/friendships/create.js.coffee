<% if @friendship.new_record? %>
  $("#<%= dom_id(@friendship.friend) %>").fadeOut ->
    $(this).fadeIn()
      
<% else %>
  # Reload the friend div and add the hoverIntent effect to the btn
  $("#<%= dom_id(@friendship.friend) %>").load location.href + " #<%= dom_id(@friendship.friend) %> > *", ->
    $("#<%= dom_id(@friendship.friend) %> a.btn-social").hoverIntent (->
      $(this).html("Unshare").addClass "btn-remove"
    ), ->
      $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass "btn-remove"

  # Reload the sharing counter
  $("#friendships-numbersharing").html "<%= current_user.number_sharing %>"
<% end %>