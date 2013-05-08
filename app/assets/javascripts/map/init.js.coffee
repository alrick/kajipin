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
      keyboard: false # disable for now because re-enable is buggy
    ).fitWorld()

    # Map public accessor
    gon.map = map

    # Only if user has pins to display
    if gon.hasPins

      # Create cities layer with all markers
      citiesList = []
      citiesLayer = L.geoJson gon.cities,
        pointToLayer: L.mapbox.marker.style,
        onEachFeature: (feature, layer) ->
          layer.bindPopup gon.build_tooltip(feature)
          citiesList.push(layer)

      # Create towns layer with all markers
      townsList = []
      townsLayer = L.geoJson gon.towns,
        pointToLayer: L.mapbox.marker.style,
        onEachFeature: (feature, layer) ->
          layer.bindPopup gon.build_tooltip(feature)
          townsList.push(layer)

      # Create poi layer with all markers
      poiList = []
      poiLayer = L.geoJson gon.poi,
        pointToLayer: L.mapbox.marker.style,
        onEachFeature: (feature, layer) ->
          layer.bindPopup gon.build_tooltip(feature)
          poiList.push(layer)

      # Create cluster and add to map
      cluster = new L.MarkerClusterGroup({ showCoverageOnHover:false })
      cluster.addLayers citiesList
      cluster.addLayers townsList
      cluster.addLayers poiList
      map.addLayer cluster

      $("#city-filter").click ->
        cluster.removeLayers citiesList