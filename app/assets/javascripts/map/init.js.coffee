jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Update pins data
  gon.refresh_pins = ->
    gon.watch "cities", setup_cities, true

  # Setup cities pin
  setup_cities = (cities, cascade) ->
    gon.citiesList = []
    populate_list gon.citiesList, cities
    gon.watch "towns", setup_towns, true if cascade

  # Setup towns pin
  setup_towns = (towns, cascade) ->
    gon.townsList = []
    populate_list gon.townsList, towns
    gon.watch "poi", setup_poi, true if cascade

  # Setup poi pin
  setup_poi = (poi, cascade) ->
    gon.poiList = []
    populate_list gon.poiList, poi
    if cascade
      gon.clusterGroup.clearLayers()
      add_pins()

  # Init map, only called once
  init_map = ->
    gon.map = L.mapbox.map("map", gon.mapbox_id,
      attributionControl: false
      worldCopyJump: true
      minZoom: 3
      keyboard: false # disable for now because re-enable is buggy
    ).fitWorld()
    gon.clusterGroup = new L.MarkerClusterGroup({ showCoverageOnHover:false })
    gon.map.addLayer gon.clusterGroup

  # Populate a list with pins
  populate_list = (list, pins) ->
    L.geoJson pins,
      pointToLayer: L.mapbox.marker.style,
      onEachFeature: (feature, layer) ->
        layer.bindPopup gon.build_tooltip feature
        list.push layer

  # Set and add clusters to map
  add_pins = ->
    gon.clusterGroup.addLayers gon.citiesList
    gon.clusterGroup.addLayers gon.townsList
    gon.clusterGroup.addLayers gon.poiList

  # Set all the pins stuff
  init_pins = ->
    setup_cities gon.cities, false
    setup_towns gon.towns, false
    setup_poi gon.poi, false
    add_pins()


  #################
  # FLOW
  #################

  # Check that we're on correct page
  if $("#map").length
    init_map()
    init_pins() if gon.hasPins
      