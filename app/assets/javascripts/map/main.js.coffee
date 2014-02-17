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
    z = if $(window).width() > 1500 then 3 else 2
    gon.map = L.mapbox.map("map", gon.mapbox_id,
      attributionControl: false
      zoomControl: false
      #worldCopyJump: true buggy since 0.6.5
      minZoom: z
      keyboard: false # disable for now because re-enable is buggy
    ).on "zoomend", (e) ->
      zoom = gon.map.getZoom()
      if zoom == gon.map.getMinZoom()
        gon.disable_zoom("minus")
      else if zoom == gon.map.getMaxZoom()
        gon.disable_zoom("plus")
      else
        gon.enable_zoom("minus")
        gon.enable_zoom("plus")
    gon.world_zoom(gon.map)

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          100.50144
          13.75398
        ]

      properties:
        title: "Bangkok for 2 persons, from CHF 7490.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Bangkok-BKK.html?i=gcz1&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          77.22897
          28.65381
        ]

      properties:
        title: "Delhi for 2 persons, from CHF 6990.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Delhi-DEL.html?i=ocz1&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          55.30472
          25.25817
        ]

      properties:
        title: "Dubai for 2 persons, from CHF 5490.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Dubai-DXB.html?i=scz1&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          72.88261
          19.07283
        ]

      properties:
        title: "Mumbai for 2 persons, from CHF 6990.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Mumbai-BOM.html?i=0dz1&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          103.85007
          1.28967
        ]

      properties:
        title: "Singapore for 2 persons, from CHF 8990.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Singapore-SIN.html?i=8dz1&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          2.15899
          41.38879
        ]

      properties:
        title: "Barcelona, from CHF 319.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Barcelona-BCN.html?i=hG02&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          12.4839
          41.89474
        ]

      properties:
        title: "Rome, from CHF 329.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Rome-ROM.html?i=kG02&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          28.94966
          41.01384
        ]

      properties:
        title: "Istanbul, from CHF 333.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Istanbul-IST.html?i=lG02&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          -0.12574
          51.50853
        ]

      properties:
        title: "London, from CHF 399.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-London-LON.html?i=oG02&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          -87.65005
          41.85003
        ]

      properties:
        title: "Chicago, from CHF 779.-"
        description: '<a href="http://booking.swiss.com/web/Offers/from-Zurich-ZRH-to-Chicago-CHI.html?i=dF02" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          -80.19366
          25.77427
        ]

      properties:
        title: "Miami, from CHF 899.-"
        description: '<a href="http://booking.swiss.com/web/Offers/from-Zurich-ZRH-to-Miami-MIA.html?i=lF02" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          -74.00597
          40.71427
        ]

      properties:
        title: "New York, from CHF 609.-"
        description: '<a href="http://booking.swiss.com/web/Offers/from-Zurich-ZRH-to-New-York-NYC.html?i=nF02" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          28.04363
          -26.20227
        ]

      properties:
        title: "Johannesburg, from CHF 6490.-"
        description: '<a href="http://booking.swiss.com/web/Special-Offers/from-Zurich-ZRH-to-Johannesburg-JNB.html?i=KZz1&g=1" target="_blank">Click for details</a>'
        "marker-size": "medium"
        "marker-color": "#701516"
        "marker-symbol": "airport"
    ).addTo gon.map

  # Set all the pins stuff
  init_pins = ->
    gon.pinMap = {} # pinMap reference all the pin, whatever the type
    r = if $(window).width() > 1500 then 30 else 50
    gon.cluster = new L.MarkerClusterGroup({ showCoverageOnHover:false, maxClusterRadius:r }) # the cluster group the pins by proximity
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
          autoPan: false
          closeButton: false
          maxWidth: 8000 # intentionaly big, managed by inner containers
          maxHeight: 8000 # intentionaly big, managed by inner containers
        pin.on "popupopen", (e) ->
          pin.setPopupContent '<p class="loading-popup"></p>'
          $(".loading-popup").spin()
          build_popup(pin, feature)

  # Retrieve pin view and set the popup
  build_popup = (pin, feature) ->
    # Herald stuff here
    if gon.key
      key = "?key="+gon.key
    $.get("/pins/" + feature.id + key, (data) ->
      pin.setPopupContent(data)
      gon.adjust_popup_size()
      gon.init_mfp_gallery()
      gon.init_delete_tooltip()

      pointY = -($(".pin").height()/2+70)
      gon.map.setView(pin.getLatLng(), gon.map.getZoom())
      gon.map.panBy [0, pointY]
    )


  #################
  # FLOW
  #################

  # Check that we're on correct page
  if $("#map").length
    init_map()
    init_pins() if gon.hasPins