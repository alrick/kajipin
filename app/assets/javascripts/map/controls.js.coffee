jQuery ->

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

  # Display countries list
  gon.show_countries_list = (map) ->
    countriesList = $("#map-countrieslist")
    if countriesList.is ":hidden"
      event.stopPropagation()
      countriesList.show()
      disable_interaction(map)

  # Hide countries list
  gon.hide_countries_list = (map) ->
    countriesList = $("#map-countrieslist")
    if countriesList.is ":visible"
      countriesList.hide()
      enable_interaction(map)