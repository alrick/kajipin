jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Inc cities count
  gon.update_cities_count = ->
    count = $(".pins-count")
    count.html(parseInt(count.html())+1)
    count = $(".cities-count")
    count.html(parseInt(count.html())+1)

  # PUBLIC : Dec cities count
  gon.dec_cities_count = ->
    count = $(".pins-count")
    count.html(parseInt(count.html())-1)
    count = $(".cities-count")
    count.html(parseInt(count.html())-1)

  # PUBLIC : Inc towns count
  gon.inc_towns_count = ->
    count = $(".pins-count")
    count.html(parseInt(count.html())+1)
    count = $(".towns-count")
    count.html(parseInt(count.html())+1)

  # PUBLIC : Dec towns count
  gon.dec_towns_count = ->
    count = $(".pins-count")
    count.html(parseInt(count.html())-1)
    count = $(".towns-count")
    count.html(parseInt(count.html())-1)

  # PUBLIC : Inc pois count
  gon.inc_pois_count = ->
    count = $(".pins-count")
    count.html(parseInt(count.html())+1)
    count = $(".pois-count")
    count.html(parseInt(count.html())+1)

  # PUBLIC : Dec pois count
  gon.dec_pois_count = ->
    count = $(".pins-count")
    count.html(parseInt(count.html())-1)
    count = $(".pois-count")
    count.html(parseInt(count.html())-1)