jQuery ->
  # Check that we're on correct page (user profile or friendships)
  if ($("#friendships-friendstabs").length > 0) || ($("#user-generalinfos").length > 0)
    
    #replace text for sharing/unshare
    $(".btn-unsocial").hover(
      -> $(this).text("Unshare"),
      -> $(this).text("Sharing")
    )

    # Display correct tab
    if (gon.tab == "s")
      $("#friendships-friendstabs a[href=\"#tab-friends-2\"]").tab("show")