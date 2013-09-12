if <%= @friendship.new_record? %>
  # Fade out and in to report an error
  $(".sharing-btn.<%= @friendship.friend.id %>").fadeOut ->
    $(this).fadeIn()
else
  # Update counter if present
  $("#sharing-counter").html "<%= @friendship.user.sharing_count %>" if $("#sharing-counter").length
  # Update sharing btn and reset hoverintent
  $(".sharing-btn.<%= @friendship.friend.id %>").replaceWith("<%= j(sharing_btn(@friendship.friend)) %>")
  gon.init_hoverintent()