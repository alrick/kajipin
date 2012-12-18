jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)

    # Center information block if present
    if ($("#map-infocenter").length > 0)
      padding = $("#map-infocenter").css("padding-top").replace("px", "")
      padding = padding*2
      height = $("#map-infocenter").height()
      topmargin = ((padding+height)/2) * -1
      $("#map-infocenter").css("margin-top", topmargin)

    # Update pins
    updatepins = (pins) ->
      gon.pinsLayer.features(pins)

    # Trigger buttons to update pins
    $(".map-updatepins").click ->
      if $(this).attr("id") == "map-refresh"
        $(this).find(':first-child').fadeOut ->
          $(this).attr("class", "icon-time")
          $(this).fadeIn ->
            $(this).fadeOut ->
              $(this).attr("class", "icon-refresh")
              $(this).fadeIn()
      gon.watch('pins', updatepins)