#################
# TRIGGERS
#################
$(document).ready ->

  # Trigger clicks on avatar
  $(".avatar").hoverIntent (->
    $(this).find("div").fadeIn()
  ), ->
    $(this).find("div").fadeOut()