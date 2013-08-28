<% if @friendship.destroyed? %>

  # Load element containing sharing button
  container = $("#<%= dom_id(@friendship.friend) %>")

  # Reload the full container
  container.load location.href + " #<%= dom_id(@friendship.friend) %> > *"

  # Update counter if present
  $("#sharing-counter").html "<%= @friendship.user.sharing_count %>" if $("#sharing-counter").length

  # Fade out the friend if is not sharer and we're on friendships page
  if (!container.hasClass "sharer-userbox") && $("#friendships").length
    container.fadeOut()

<% else %>

  # Fade out and in to report an error
  $("#<%= dom_id(@friendship.friend) %>").fadeOut ->
    $(this).fadeIn()

<% end %>