if <%= @friendship.destroyed? %>
  # Update counter if present
  $("#sharing-counter").html "<%= @friendship.user.sharing_count %>" if $("#sharing-counter").length
  # Fade out the friend if is not sharer and we're on friendships page
  userbox = $("#<%= dom_id(@friendship.friend) %>")
  if $("#friendships").length && !userbox.hasClass("sharer-userbox")
    userbox.fadeOut()
  else
    $(".sharing-btn.<%= @friendship.friend.id %>").replaceWith("<%= j(sharing_btn(@friendship.friend)) %>")
else
  # Fade out and in to report an error
  $(".sharing-btn.<%= @friendship.friend.id %>").fadeOut ->
    $(this).fadeIn()