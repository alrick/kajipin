jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Allow to enable all zooming and paning
  gon.enable_interaction = (map) ->
    map.dragging.enable()
    map.touchZoom.enable()
    map.scrollWheelZoom.enable()
    map.doubleClickZoom.enable()
    map.boxZoom.enable()
    map.keyboard.enable()

  # PUBLIC : Allow to disable all zooming and paning
  gon.disable_interaction = (map) ->
    map.dragging.disable()
    map.touchZoom.disable()
    map.scrollWheelZoom.disable()
    map.doubleClickZoom.disable()
    map.boxZoom.disable()
    map.keyboard.disable()

  # Filter side pins
  filter_side_pins = (type, state) ->
    type = "."+type
    side = $("#side")
    if state
      side.find(type).fadeIn()
    else
      side.find(type).fadeOut()

  # Filter map pins
  filter_map_pins = (type, state) ->
    if type == "City"
      layer = gon.citiesLayer
    else if type == "Town"
      layer = gon.townsLayer
    else if type == "Poi"
      layer = gon.poisLayer
    if state
      gon.cluster.addLayers(layer.getLayers())
    else
      gon.cluster.removeLayers(layer.getLayers())

  # Display countries list
  show_countries_list = (map) ->
    countriesList = $("#countries-list")
    if countriesList.is ":hidden"
      event.stopPropagation()
      countriesList.show()
      gon.disable_interaction(map)

  # Hide countries list
  hide_countries_list = (map) ->
    countriesList = $("#countries-list")
    if countriesList.is ":visible"
      countriesList.hide()
      gon.enable_interaction(map)

  # Get data from button and setview
  setview_from_button = (map) ->
    lat = $(this).data "lat"
    lon = $(this).data "lon"
    zoom = $(this).data "zoom"
    map.setView([lat, lon], zoom)

  # Filter pins
  filter_pins = ->
    icon = $(this).find("i").toggleClass "icon-eye-open icon-eye-close"
    type = $(this).data "type"
    state = icon.hasClass "icon-eye-open"
    filter_side_pins(type, state)
    filter_map_pins(type, state)


  #################
  # FLOW
  #################

  # Add pins tip if needed
  if !gon.hasPins
    $("#pin-initiator").tooltip "show"
    $("#pin-initiator-tooltip").closest(".tooltip").css({"font-size": "14px", "font-weight": "bold", "left": "", "right": "43px"})


  #################
  # TRIGGERS
  #################

  # Set worldmap zoom func
  $("#world-zoom").click ->
    gon.map.fitWorld()

  # Set countries bounds func
  $(".country-item").click ->
    gon.map.fitBounds([
      [$(this).attr("data-south"), $(this).attr("data-west")],
      [$(this).attr("data-north"), $(this).attr("data-east")]
    ])

  # Set the countries list button trigger
  $("#countries-zoom").click ->
    show_countries_list(gon.map)

  # Hide the countries list on click if visible
  $("html").click ->
    hide_countries_list(gon.map)

  # Click on the list doesn't hide it
  $("#countries-list").click (event) ->
    event.stopPropagation()

  # Locate a pin when click from side
  $("#side").on "click", ".btn-locate", ->
    setview_from_button.call(this, gon.map)

  # Only if user has pins to display
  if gon.hasPins

    # Show and hide city pins
    $("#city-filter").click ->
      filter_pins.call this

    # Show and hide town pins
    $("#town-filter").click ->
      filter_pins.call this

    # Show and hide poi pins
    $("#poi-filter").click ->
      filter_pins.call this