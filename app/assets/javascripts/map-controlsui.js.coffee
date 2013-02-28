jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)

    # Set worldmap zoom func
    $("#map-world").click ->
      gon.map.centerzoom({ lat: 24.06, lon: 13.33 }, 3, false);

    # Cinch the map display to show all markers
    $("#map-markers").click ->
      if gon.pinsLayer
        gon.map.setExtent(gon.pinsLayer.extent())

    # Set countries bounds func
    $(".map-countryitem").click ->
      gon.map.setExtent(new MM.Extent($(this).attr("data-north"), $(this).attr("data-west"), $(this).attr("data-south"), $(this).attr("data-east")))

    # Display list of countries when button clicked
    $("#map-countries").click (event) ->
      if ($("#map-countrieslist").css("display") == "none")
        event.stopPropagation()
        $("#map-countrieslist").css("display", "block")

    # Hide list of countries if click outside
    $("html").click ->
      if ($("#map-countrieslist").css("display") == "block")
        $("#map-countrieslist").css("display", "none")
    # Stop hiding if in the list
    $("#map-countrieslist").click (event) ->
        event.stopPropagation()

    # Zoom on a pin func
    $(document).on "click", ".map-tooltipzoom", ->
      lat = $(this).attr("data-lat")
      lon = $(this).attr("data-lon")
      title = $(this).attr("data-title")
      gon.map.ease.location({ lat: lat, lon: lon })
      gon.map.ease.zoom(12)
      gon.map.ease.easing('linear')
      $(".map-ease span").html("Moving to "+title)
      gon.map.ease.optimal 0.9, 1.42, ->
        $(".map-ease").fadeOut()
      if gon.map.ease.running()
        $(".map-ease").fadeIn()

    # Bind esc key and cancel to stop animation
    $(".map-ease .skip").click ->
      if gon.map.ease.running()
          gon.map.ease.stop ->
            gon.map.ease.t(1)
            $(".map-ease").fadeOut()
    $(document).keyup (e) ->
      if e.keyCode is 27 # 27 is esc
        if gon.map.ease.running()
          gon.map.ease.stop ->
            gon.map.ease.t(1)
            $(".map-ease").fadeOut()