jQuery ->

  # Auto fade alert-success alert after a delay
  $(".alert-success").delay(3000).fadeOut "slow", ->
    $(this).remove()

  # Check that we're on correct page (user profile or friendships)
  if ($(".userbox").length > 0) or ($("#userModal").length > 0)
    
    #replace text for sharing/unshare
    $(".btn-unsocial").hoverIntent(
      -> $(this).html("Unshare").addClass("btn-remove"),
      -> $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass("btn-remove")
    )