jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Change pin icon
  gon.change_pin_icon = (id, size, symbol, color) ->
    gon.pinMap[id].setIcon(L.mapbox.marker.icon({'marker-size': size, 'marker-symbol': symbol, 'marker-color': color}))

  # PUBLIC : Remove pin properly
  gon.remove_pin = (id) ->
    pin = gon.pinMap[id]
    type = pin.feature.properties.type
    gon.cluster.removeLayer(pin)
    if type == "City"
      gon.citiesLayer.removeLayer(pin)
    else if type == "Town"
      gon.townsLayer.removeLayer(pin)
    else if type == "Poi"
      gon.poisLayer.removeLayer(pin)

  # Init map, only called once
  init_map = ->
    gon.map = L.mapbox.map("map", gon.mapbox_id,
      attributionControl: false
      worldCopyJump: true
      minZoom: 3
      keyboard: false # disable for now because re-enable is buggy
    ).fitWorld()

  # Set all the pins stuff
  init_pins = ->
    gon.pinMap = {} # pinMap reference all the pin, whatever the type
    gon.cluster = new L.MarkerClusterGroup({ showCoverageOnHover:false, maxClusterRadius:30 }) # the cluster group the pins by proximity
    gon.citiesLayer = init_layer(gon.cities) # layer grouping all cities
    gon.townsLayer = init_layer(gon.towns) # layer grouping all towns
    gon.poisLayer = init_layer(gon.pois) # layer grouping all pois
    gon.cluster.addLayers(gon.citiesLayer.getLayers())
    gon.cluster.addLayers(gon.townsLayer.getLayers())
    gon.cluster.addLayers(gon.poisLayer.getLayers())
    gon.map.addLayer gon.cluster

  # Add pins to layer and init behaviour
  init_layer = (pins) ->
    L.geoJson pins,
      pointToLayer: L.mapbox.marker.style,
      onEachFeature: (feature, pin) ->
        gon.pinMap[feature.id] = pin
        pin.bindPopup '<p class="loading-popup"></p>',
          closeButton: false
          maxWidth: 2000 # intentionaly big, managed by inner containers
          maxHeight: 2000 # intentionaly big, managed by inner containers
        pin.on "click", (e) ->
          build_popup(pin, feature, e)
        pin.on "popupopen", (e) ->
          $(".loading-popup").spin()

  # Retrieve pin view and set the popup
  build_popup = (layer, feature, e) ->
    $.get("/pins/" + feature.id, (data) ->
      layer.setPopupContent(data)
      gon.init_mfp_gallery()
      gon.init_delete_tooltip()
      gon.map.panTo [gon.map.getCenter().lat, e.latlng.lng]
    )


  #################
  # FLOW
  #################

  # Check that we're on correct page
  if $("#map").length
    init_map()
    init_pins() if gon.hasPins