jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)


    #########################################
    #### INITIALISATION
    #########################################

    # Map init
    map = mapbox.map("map")
    map.addLayer(mapbox.layer().url("http://a.tiles.mapbox.com/v3/alrick.map-y17w9hkl.jsonp", () ->
      map.ui.refresh()))

    # Map config
    map.zoom(3)
    map.center({ lat: 24.06, lon: 13.33 })
    map.ui.attribution.add()
    map.ui.zoombox.add()
    map.ui.zoomer.add()
    map.ui.hash.add()
    map.setZoomRange(3, 17)

    # Only if user has pins to diplay
    if gon.pins and gon.pins.length > 0
      # Create all empty markers layer & group vars
      pinsLayer = mapbox.markers.layer()
      bigcityMarkers = true
      smallcityMarkers = true
      pointofinterestMarkers = true

      # Add all pin of the user into the right layer
      pinsLayer.features(gon.pins)

      # Add interaction to this marker layers (title and description)
      interaction = mapbox.markers.interaction(pinsLayer)

      # Add layers to the map
      map.addLayer(pinsLayer)

      # Define formater for pins tooltips
      interaction.formatter (feature) ->
        tooltipTitle = "<h2 class=\"map-tooltiptitle\">" + feature.properties.title + "</h2>"
        tooltipCountry = "<h3 class=\"map-tooltipcountry\">" + feature.properties.country_name + "</h3>"
        tooltipGalleries = "<a href=\"#\" class=\"btn btn-small btn-tool map-tooltipbtn\">" + feature.properties.galleries_count + "&nbsp;<i class=\"icon-camera\"></i></a>&nbsp;"
        tooltipLogbook = "<a href=\"#\" class=\"btn btn-small btn-tool map-tooltipbtn\">" + feature.properties.logpages_count + "&nbsp;<i class=\"icon-book\"></i></a>&nbsp;"
        tooltipComments = "<a href=\"#\" class=\"btn btn-small btn-tool map-tooltipbtn\">" + feature.properties.comments_count + "&nbsp;<i class=\"icon-comment\"></i></a>" 
        o = tooltipTitle + tooltipCountry + tooltipGalleries + tooltipLogbook + tooltipComments

      # By default, the map extent markers
      map.extent(pinsLayer.extent())
      
    # Else display a little message
    else
      $("#map-infocenter").css("display", "block")

    # Set intent if pin selected
    if (gon.plat && gon.plon)
      map.centerzoom({ lat: gon.plat, lon: gon.plon }, 12)


    #########################################
    #### LEFT UI
    #########################################

    # Set worldmap zoom func
    $("#map-world").click -> 
      map.zoom(3)
      map.center({ lat: 24.06, lon: 13.33 })

    # Cinch the map display to show all markers
    $("#map-markers").click ->
      if pinsLayer
        map.extent(pinsLayer.extent())

    # Set countries bounds func
    $(".map-countryitem").click ->
      map.setExtent(new MM.Extent($(this).attr("data-north"), $(this).attr("data-west"), $(this).attr("data-south"), $(this).attr("data-east")));

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


    #########################################
    #### RIGHT UI
    #########################################

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
        pinsLayer.filter (f) ->
          true
      else if (bigcityMarkers && smallcityMarkers && !pointofinterestMarkers)
        pinsLayer.filter (f) ->
          (f.properties.locategory_hook is 1) or (f.properties.locategory_hook is 2)
      else if (bigcityMarkers && !smallcityMarkers && pointofinterestMarkers)
        pinsLayer.filter (f) ->
          (f.properties.locategory_hook is 1) or (f.properties.locategory_hook is 3)
      else if (bigcityMarkers && !smallcityMarkers && !pointofinterestMarkers)
        pinsLayer.filter (f) ->
          (f.properties.locategory_hook is 1)
      else if (!bigcityMarkers && smallcityMarkers && pointofinterestMarkers)
        pinsLayer.filter (f) ->
          (f.properties.locategory_hook is 2) or (f.properties.locategory_hook is 3)
      else if (!bigcityMarkers && smallcityMarkers && !pointofinterestMarkers)
        pinsLayer.filter (f) ->
          (f.properties.locategory_hook is 2)
      else if (!bigcityMarkers && !smallcityMarkers && pointofinterestMarkers)
        pinsLayer.filter (f) ->
          (f.properties.locategory_hook is 3)
      else if (!bigcityMarkers && !smallcityMarkers && !pointofinterestMarkers)
        pinsLayer.filter (f) ->
          false


    #########################################
    #### CENTER UI
    #########################################

    # Center information block if present
    if ($("#map-infocenter").length > 0)
      topmargin = ($("#map-infocenter").height()/2) * -1
      $("#map-infocenter").css("margin-top", topmargin)
