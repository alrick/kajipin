jQuery ->

  #################
  # FUNCTIONS
  #################

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
      init_mfp_gallery()
      init_delete_tooltip()
      gon.map.panTo [gon.map.getCenter().lat, e.latlng.lng]
    )

  # Init gallery when popup set
  init_mfp_gallery = ->
    $('.photos').magnificPopup
      key: "pin-photos"
      preload: [0,2]
      delegate: "a"
      gallery:
        enabled: true

  # Init delete tooltip
  init_delete_tooltip = ->
    $("a[rel=delete-tooltip]").tooltip(
      html: true
      placement: "left"
      trigger: "click"
    ).on("show", (e) ->
      e.stopPropagation()
    ).on "hide", (e) ->
      e.stopPropagation()


  #################
  # FLOW
  #################

  # Check that we're on correct page
  if $("#map").length
    init_map()
    init_pins() if gon.hasPins
      