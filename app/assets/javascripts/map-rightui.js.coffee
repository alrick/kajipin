jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)
    
    # Init vars for pinsfilter
    bigcityMarkers = true
    smallcityMarkers = true
    pointofinterestMarkers = true

    # Show and hide bigcity pins
    $("#map-bigcity").click ->
      #if $(this).children().hasClass("icon-eye-open")
      bigcityMarkers = !bigcityMarkers
      $(this).children().toggleClass("icon-eye-open icon-eye-close")
      pinsfilter()

    # Show and hide smallcity pins
    $("#map-smallcity").click ->
      smallcityMarkers = !smallcityMarkers
      $(this).children().toggleClass("icon-eye-open icon-eye-close")
      pinsfilter()

    # Show and hide bigcity pins
    $("#map-pointofinterest").click ->
      pointofinterestMarkers = !pointofinterestMarkers
      $(this).children().toggleClass("icon-eye-open icon-eye-close")
      pinsfilter()

    # Filter pins
    pinsfilter = () ->
      if (bigcityMarkers && smallcityMarkers && pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          true
      else if (bigcityMarkers && smallcityMarkers && !pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          (f.properties.type is "Bigcity") or (f.properties.type is "Smallcity")
      else if (bigcityMarkers && !smallcityMarkers && pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          (f.properties.type is "Bigcity") or (f.properties.type is "Poi")
      else if (bigcityMarkers && !smallcityMarkers && !pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          (f.properties.type is "Bigcity")
      else if (!bigcityMarkers && smallcityMarkers && pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          (f.properties.type is "Smallcity") or (f.properties.type is "Poi")
      else if (!bigcityMarkers && smallcityMarkers && !pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          (f.properties.type is "Smallcity")
      else if (!bigcityMarkers && !smallcityMarkers && pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          (f.properties.type is "Poi")
      else if (!bigcityMarkers && !smallcityMarkers && !pointofinterestMarkers)
        gon.pinsLayer.filter (f) ->
          false