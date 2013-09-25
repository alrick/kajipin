jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Locate pin and open popup
  gon.locate_pin = ->
    id = $(this).data "id"
    pin = gon.pinMap[id]
    gon.cluster.zoomToShowLayer pin, ->
      pin.openPopup()

  # PUBLIC : Define our world zoom
  gon.world_zoom = ->
    gon.map.setView([30.524413,11.733398], gon.map.getMinZoom())

  # PUBLIC : Allow to enable zoom button
  gon.enable_zoom = (zoom) ->
    $("#"+zoom+"-zoom").removeClass("disable")

  # PUBLIC : Allow to disable zoom button
  gon.disable_zoom = (zoom) ->
    $("#"+zoom+"-zoom").addClass("disable")

  # PUBLIC : Allow to enable all zooming and paning
  gon.enable_interaction = ->
    gon.map.dragging.enable()
    gon.map.touchZoom.enable()
    gon.map.scrollWheelZoom.enable()
    gon.map.doubleClickZoom.enable()
    gon.map.boxZoom.enable()
    gon.map.keyboard.enable()

  # PUBLIC : Allow to disable all zooming and paning
  gon.disable_interaction = ->
    gon.map.dragging.disable()
    gon.map.touchZoom.disable()
    gon.map.scrollWheelZoom.disable()
    gon.map.doubleClickZoom.disable()
    gon.map.boxZoom.disable()
    gon.map.keyboard.disable()

  # Filter map pins
  filter_map_pins = (type, state) ->
    if type == "city"
      layer = gon.citiesLayer
    else if type == "town"
      layer = gon.townsLayer
    else if type == "poi"
      layer = gon.poisLayer
    if state
      gon.cluster.addLayers(layer.getLayers())
    else
      gon.cluster.removeLayers(layer.getLayers())

  # Display countries list
  show_countries_list = ->
    countriesList = $("#countries-list")
    if countriesList.is ":hidden"
      event.stopPropagation()
      countriesList.show()
      gon.disable_interaction()

  # Hide countries list
  hide_countries_list = ->
    countriesList = $("#countries-list")
    if countriesList.is ":visible"
      countriesList.hide()
      gon.enable_interaction()

  # Filter pins
  filter_pins = ->
    icon = $(this).find("i").toggleClass "icon-eye-open icon-eye-close"
    type = $(this).data("type").toLowerCase()
    state = icon.hasClass "icon-eye-open"
    gon.filter_list_pins(type, state)
    filter_map_pins(type, state)


  #################
  # TRIGGERS
  #################

  # Set plus zoom func
  $("#plus-zoom").click ->
    gon.map.zoomIn()

  # Set minus zoom func
  $("#minus-zoom").click ->
    gon.map.zoomOut()

  # Set worldmap zoom func
  $("#world-zoom").click ->
    gon.world_zoom()

  # Set countries bounds func
  $(".country-item").click ->
    gon.map.fitBounds([
      [$(this).attr("data-south"), $(this).attr("data-west")],
      [$(this).attr("data-north"), $(this).attr("data-east")]
    ])

  # Set the countries list button trigger
  $("#countries-zoom").click ->
    show_countries_list()

  # Hide the countries list on click if visible
  $("html").click ->
    hide_countries_list()

  # Click on the list doesn't hide it
  $("#countries-list").click (event) ->
    event.stopPropagation()

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