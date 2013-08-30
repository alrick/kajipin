jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Inc pins count
  gon.inc_pins_count = (type) ->
    count = $(".pins-count")
    count.html(parseInt(count.html())+1)
    if type == "City"
      count = $(".cities-count")
    else if type == "Town"
      count = $(".towns-count")
    else if type == "Poi"
      count = $(".pois-count")
    count.html(parseInt(count.html())+1)

  # PUBLIC : Dec pins count
  gon.dec_pins_count = (type) ->
    count = $(".pins-count")
    count.html(parseInt(count.html())-1)
    if type == "City"
      count = $(".cities-count")
    else if type == "Town"
      count = $(".towns-count")
    else if type == "Poi"
      count = $(".pois-count")
    count.html(parseInt(count.html())-1)