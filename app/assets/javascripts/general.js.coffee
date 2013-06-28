jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Render a loading state
  gon.loading = ->
    $("<div id=\"loading-backdrop\" class=\"modal-backdrop\"></div>").appendTo("body")
    $("#loading-backdrop").spin
      lines: 11 # The number of lines to draw
      length: 35 # The length of each line
      width: 9 # The line thickness
      radius: 48 # The radius of the inner circle
      color: "#fff" # #rgb or #rrggbb
      speed: 1 # Rounds per second
      trail: 60 # Afterglow percentage
      shadow: false # Whether to render a shadow

  # PUBLIC : Stop the loading state
  gon.stop_loading = ->
    $("#loading-backdrop").spin(false)
    $("#loading-backdrop").remove()
  
  # Display the side bar next to the map
  toggler = ->
    map = $("#map")
    side = $("#side")

    $(this).toggleClass "active"
    if $(this).hasClass "active"
      map.width $("#main").width()-344
      side.show()
    else
      side.hide()
      map.css "width", "100%"


  #################
  # FLOW
  #################

  # Set tooltip integration
  $("a[rel~=tooltip]").tooltip()
  $("button[rel~=tooltip]").tooltip()

  # Auto fade alert-success alert after a delay
  $(".alert-success").delay(3000).fadeOut "slow"


  #################
  # TRIGGERS
  #################      

  # Toggler allow to activate the left sidebar
  $("#toggler").click toggler

  # Set unsocial behaviour
  $(".btn-unsocial").hoverIntent(
    -> $(this).html("Unshare").addClass("btn-remove"),
    -> $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass("btn-remove")
  )