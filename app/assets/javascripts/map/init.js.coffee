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

      # Create pinsLayer with all markers
      pinsLayer = L.geoJson gon.pins,
        pointToLayer: L.mapbox.marker.style,
        onEachFeature: (feature, layer) ->
          layer.bindPopup gon.build_tooltip(feature)

      # Create cluster and add to map
      cluster = new L.MarkerClusterGroup({ showCoverageOnHover:false })
      cluster.addLayer pinsLayer
      map.addLayer cluster