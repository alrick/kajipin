$(document).ready ->
  # Check that we're on correct page
  if $("#map").length > 0

    #################
    # FLOW
    #################

    # Map init
    map = L.mapbox.map("map", gon.mapbox_id,
      attributionControl: false
      maxBounds: [[-90,-180.0],[90,180.0]]
    ).fitWorld()

    # Only if user has pins to display
    if gon.hasPins

      # Create markerLayers for each type of pins
      bctLayer = L.mapbox.markerLayer(gon.bctPins).addTo map
      sctLayer = L.mapbox.markerLayer(gon.sctPins).addTo map
      poiLayer = L.mapbox.markerLayer(gon.poiPins).addTo map

    #################
    # TRIGGERS
    #################

    # Set worldmap zoom func
    $("#map-world").click ->
      map.fitWorld()

    # Set countries bounds func
    $(".map-countryitem").click ->
      map.fitBounds([
        [$(this).attr("data-south"), $(this).attr("data-west")],
        [$(this).attr("data-north"), $(this).attr("data-east")]
      ])

    # Only if user has pins to display
    if gon.hasPins

      # Show and hide bigcity pins
      $("#map-bigcity").click ->
        gon.toggle_action.call(this, bctLayer)

      # Show and hide smallcity pins
      $("#map-smallcity").click ->
        gon.toggle_action.call(this, sctLayer)

      # Show and hide bigcity pins
      $("#map-pointofinterest").click ->
        gon.toggle_action.call(this, poiLayer)


# Add interaction to this marker layers (title and description)
      #interaction = mapbox.markers.interaction(pinsLayer)

      # Add layers to the map
      #map.addLayer(pinsLayer)

      # Define formater for pins tooltips
      #interaction.formatter (feature) ->
      #  tooltipTitle = '<h2 class="map-tooltiptitle">' + feature.properties.title + '</h2>'
      #  tooltipCountry = '<h3 class="map-tooltipcountry">' + feature.properties.country_name + '</h3>'
      #  tooltipPhotos = '<a href="' + feature.properties.photos_path + '" class="btn btn-small btn-tool map-tooltipbtn modal-open" data-remote="true">' + feature.properties.photos_count + '&nbsp;<i class="icon-camera-retro"></i></a>'
      #  tooltipComments = '<a href="' + feature.properties.comments_path + '" class="btn btn-small btn-tool map-tooltipbtn modal-open" data-remote="true">' + feature.properties.comments_count + '&nbsp;<i class="icon-comments"></i></a>'
      #  tooltipLogbook = '<a href="' + feature.properties.logpages_path + '" class="btn btn-small btn-tool map-tooltipbtn modal-open" data-remote="true">' + feature.properties.logpages_count + '&nbsp;<i class="icon-book"></i></a>'
      #  tooltipZoom = '<a class="btn btn-small btn-map map-tooltipbtn map-tooltipzoom" data-lat="' + feature.geometry.coordinates[1] + '" data-lon="' + feature.geometry.coordinates[0] + '" data-title="' + feature.properties.title + '"><i class="icon-zoom-in"></i></a>'
      #  o = '<div style="text-align:center">' + tooltipTitle + tooltipCountry + '<div class="btn-group">' + tooltipPhotos + tooltipComments + tooltipLogbook + '</div><div>' + tooltipZoom + '</div></div>'

      # By default, the map extent markers
      #map.extent(pinsLayer.extent())