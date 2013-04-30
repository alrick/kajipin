jQuery ->

  #################
  # TRIGGERS
  #################

  # Trigger clicks on avatar
  $(".avatar").hoverIntent (->
    buttons = $(this).find("div")
    width = buttons.width()
    buttons.css("margin-left", -(width/2)).fadeIn()
  ), ->
    $(this).find("div").fadeOut()