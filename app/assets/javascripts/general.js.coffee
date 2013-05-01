jQuery ->

  #################
  # FUNCTIONS
  #################
  toggler = ->
    main = $("#main")
    map = $("#map")
    side = $("#side")

    $(this).toggleClass "active"
    if $(this).hasClass "active"
      map.width main.width()-300
      side.show()
    else
      side.hide()
      map.css "width", "100%"


  #################
  # FLOW
  #################

  # Set tooltip integration
  $("a[rel~=tooltip]").tooltip()

  # Updage background on not looged in pages
  if $(".notlogged-title").length > 0
    $("body").css("background", "#4A4356")

  # Auto fade alert-success alert after a delay
  if $(".notlogged-title").length < 1
    $(".alert-success").delay(3000).fadeOut "slow"


  #################
  # TRIGGERS
  #################      

  # Toggler allow to activate the left sidebar
  $("#toggler").click toggler

  

  

  # Check that we're on correct page (user profile or friendships)
  if $(".userbox").length > 0
    #replace text for sharing/unshare
    $(".btn-unsocial").hoverIntent(
      -> $(this).html("Unshare").addClass("btn-remove"),
      -> $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass("btn-remove")
    )