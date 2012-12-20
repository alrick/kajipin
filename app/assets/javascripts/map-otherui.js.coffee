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

    # Trigger buttons to update pins
    $("#map-refresh").click ->
      $(this).find(':first-child').fadeOut ->
        $(this).attr("class", "icon-time")
        $(this).fadeIn ->
          $(this).fadeOut ->
            $(this).attr("class", "icon-refresh")
            $(this).fadeIn()
      gon.watch "pins", (pins) ->
        gon.pinsLayer.features(pins)

    # Update pins when modal is hide
    $("#pinModal").on "hide", ->
      gon.watch "pins", (pins) ->
        gon.pinsLayer.features(pins)

    # Zoom on a pin func
    $(document).on "click", ".map-tooltipzoom", ->
      lat = $(this).attr("data-lat")
      lon = $(this).attr("data-lon")
      gon.map.centerzoom({ lat: lat, lon: lon }, 12, true)