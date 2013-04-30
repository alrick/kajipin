jQuery ->

  # Display countries list
  gon.show_countries_list = (map) ->
    countriesList = $("#map-countrieslist")
    if countriesList.is ":hidden"
      event.stopPropagation()
      countriesList.show()
      map.dragging.disable()
      map.scrollWheelZoom.disable()

  # Hide countries list
  gon.hide_countries_list = (map) ->
    countriesList = $("#map-countrieslist")
    if countriesList.is ":visible"
      countriesList.hide()
      map.dragging.enable()
      map.scrollWheelZoom.enable()