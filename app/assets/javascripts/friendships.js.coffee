jQuery ->
  # Check that we're on correct page (user profile or friendships)
  if $(".friendships-userbox").length > 0
    
    #replace text for sharing/unshare
    $(".btn-unsocial").hoverIntent(
      -> $(this).html("Unshare").addClass("btn-remove"),
      -> $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass("btn-remove")
    )