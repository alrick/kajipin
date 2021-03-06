jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Render a loading state
  gon.loading = (state) ->
    if state
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
    else
      $("#loading-backdrop").spin(false)
      $("#loading-backdrop").remove()

  # PUBLIC : Init delete tooltip
  gon.init_delete_tooltip = ->
    $("a[rel=delete-tooltip]").tooltip(
      html: true
      placement: "left"
      trigger: "click"
    ).on("show", (e) ->
      e.stopPropagation()
    ).on "hide", (e) ->
      e.stopPropagation()

  # PUBLIC : Init hoverintent on share btn
  gon.init_hoverintent = ->
    $(".btn-unsocial").hoverIntent(
      -> $(this).html("Unshare").addClass("btn-remove"),
      -> $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass("btn-remove")
    )

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

  # Init hoverintent
  gon.init_hoverintent()