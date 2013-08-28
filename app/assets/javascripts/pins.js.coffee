jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Refresh pins stat
  gon.refresh_stats = ->
    gon.watch "pinsCount", refresh_pins
    gon.watch "cityCount", refresh_cities
    gon.watch "townCount", refresh_towns
    gon.watch "poiCount", refresh_poi

  # Refresh the pins count at top of pins sidebar
  refresh_pins = (pinsCount) ->
    $("#side-pins").find(".stats").find(".pins-count").html pinsCount

  # Refresh the cities count at top of pins sidebar
  refresh_cities = (cityCount) ->
    $("#side-pins").find(".stats").find(".city-count").html cityCount

  # Refresh the towns count at top of pins sidebar
  refresh_towns = (townCount) ->
    $("#side-pins").find(".stats").find(".town-count").html townCount

  # Refresh the poi count at top of pins sidebar
  refresh_poi = (poiCount) ->
    $("#side-pins").find(".stats").find(".poi-count").html poiCount