jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)

    # Map init
    map = L.mapbox.map("map", gon.mapbox_id,
      center: [24.06, 13.33]
      zoom: 3
      minZoom: 3
      maxZoom: 17
      worldCopyJump: true
      attributionControl: false
    )

    # Only if user has pins to diplay
    if gon.pins and gon.pins.length > 0
      # Create all empty markers layer & group vars
      pinsLayer = mapbox.markers.layer()

      # Add all pin of the user into the right layer
      pinsLayer.features(gon.pins)

      # Add interaction to this marker layers (title and description)
      interaction = mapbox.markers.interaction(pinsLayer)

      # Add layers to the map
      map.addLayer(pinsLayer)

      # Define formater for pins tooltips
      interaction.formatter (feature) ->
        tooltipTitle = '<h2 class="map-tooltiptitle">' + feature.properties.title + '</h2>'
        tooltipCountry = '<h3 class="map-tooltipcountry">' + feature.properties.country_name + '</h3>'
        tooltipPhotos = '<a href="' + feature.properties.photos_path + '" class="btn btn-small btn-tool map-tooltipbtn modal-open" data-remote="true">' + feature.properties.photos_count + '&nbsp;<i class="icon-camera-retro"></i></a>'
        tooltipComments = '<a href="' + feature.properties.comments_path + '" class="btn btn-small btn-tool map-tooltipbtn modal-open" data-remote="true">' + feature.properties.comments_count + '&nbsp;<i class="icon-comments"></i></a>'
        tooltipLogbook = '<a href="' + feature.properties.logpages_path + '" class="btn btn-small btn-tool map-tooltipbtn modal-open" data-remote="true">' + feature.properties.logpages_count + '&nbsp;<i class="icon-book"></i></a>'
        tooltipZoom = '<a class="btn btn-small btn-map map-tooltipbtn map-tooltipzoom" data-lat="' + feature.geometry.coordinates[1] + '" data-lon="' + feature.geometry.coordinates[0] + '" data-title="' + feature.properties.title + '"><i class="icon-zoom-in"></i></a>'
        o = '<div style="text-align:center">' + tooltipTitle + tooltipCountry + '<div class="btn-group">' + tooltipPhotos + tooltipComments + tooltipLogbook + '</div><div>' + tooltipZoom + '</div></div>'

      # By default, the map extent markers
      map.extent(pinsLayer.extent())

    # Export map and pinsLayer for subsequent treatments
    gon.map = map
    gon.pinsLayer = pinsLayer