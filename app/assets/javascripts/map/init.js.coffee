jQuery ->

  # Check that we're on correct page
  if $("#map").length

    #################
    # MAP INIT
    #################

    # Create map
    map = L.mapbox.map("map", gon.mapbox_id,
      attributionControl: false
      worldCopyJump: true
      minZoom: 3
      #maxBounds: [[-90,-180.0],[90,180.0]] seems buggy for now
    ).fitWorld()

    # Map public accessor
    gon.map = map

    # Only if user has pins to display
    if gon.hasPins

      # Create markerLayers for each type of pins

      pinsLayer = L.geoJson gon.pins,
        pointToLayer: L.mapbox.marker.style,
        onEachFeature: (feature, layer) ->
          layer.bindPopup "hello"#feature.properties.description

      #pinsLayer = L.mapbox.markerLayer(gon.pins)

      # Create cluster
      cluster = new L.MarkerClusterGroup({ showCoverageOnHover:false })
      cluster.addLayer pinsLayer

      # Add cluster to map
      map.addLayer cluster


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