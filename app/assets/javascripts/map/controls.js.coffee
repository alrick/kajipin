jQuery ->

  #################
  # PRIVATE
  #################

  # Allow to enable all zooming and paning
  enable_interaction = (map) ->
    map.dragging.enable()
    map.touchZoom.enable()
    map.scrollWheelZoom.enable()
    map.doubleClickZoom.enable()
    map.boxZoom.enable()
    map.keyboard.enable()

  # Allow to disable all zooming and paning
  disable_interaction = (map) ->
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


  #################
  # PUBLIC
  #################

  # Display countries list
  gon.show_countries_list = (map) ->
    countriesList = $("#countries-list")
    if countriesList.is ":hidden"
      event.stopPropagation()
      countriesList.show()
      disable_interaction(map)

  # Hide countries list
  gon.hide_countries_list = (map) ->
    countriesList = $("#countries-list")
    if countriesList.is ":visible"
      countriesList.hide()
      enable_interaction(map)

  # Get data from button and setview
  gon.setview_from_button = (map) ->
    lat = $(this).data "lat"
    lon = $(this).data "lon"
    zoom = $(this).data "zoom"
    map.setView([lat, lon], zoom)

  # Filter pins
  gon.filter_pins = ->
    icon = $(this).find("i").toggleClass "icon-eye-open icon-eye-close"
    type = $(this).data "type"
    state = icon.hasClass "icon-eye-open"
    filter_side_pins(type, state)