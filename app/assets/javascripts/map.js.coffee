jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)

    # Map init
    map = mapbox.map('map')
    map.addLayer(mapbox.layer().url('http://a.tiles.mapbox.com/v3/alrick.map-y17w9hkl.jsonp', () ->
      map.ui.refresh()))

    # Map config
    map.zoom(3)
    map.center({ lat: 24.06, lon: 13.33 })
    map.ui.attribution.add()
    map.ui.zoombox.add()
    map.ui.zoomer.add()
    map.ui.hash.add()
    map.setZoomRange(3, 17)

    # Create an empty markers layer
    markerLayer = mapbox.markers.layer()

    # Add all location of the user
    markerLayer.features(gon.pins)

    # Add interaction to this marker layer (title and description)
    mapbox.markers.interaction(markerLayer)
    map.addLayer(markerLayer)

    # By default, the map extent markers
    map.extent(markerLayer.extent())

    # Set intent if location selected
    if (gon.plat && gon.plon)
      map.centerzoom({ lat: gon.plat, lon: gon.plon }, 12)

    # Set worldmap zoom func
    $('#map-world').click -> 
      map.zoom(3)
      map.center({ lat: 24.06, lon: 13.33 })

    # Cinch the map display to show all markers
    $('#map-markers').click ->
      map.extent(markerLayer.extent())

    # Set countries bounds func
    $('.map-countryitem').click ->
      map.setExtent(new MM.Extent($(this).attr("data-north"), $(this).attr("data-west"), $(this).attr("data-south"), $(this).attr("data-east")));

    # Display list of countries when button clicked
    $('#map-countries').click (event) ->
      if ($('#map-countrieslist').css("display") == "none")
        event.stopPropagation()
        $('#map-countrieslist').css("display", "block")

    # Hide list of countries if click outside
    $('html').click ->
      if ($('#map-countrieslist').css("display") == "block")
        $('#map-countrieslist').css("display", "none")
    # Stop hiding if in the list
    $('#map-countrieslist').click (event) ->
        event.stopPropagation()