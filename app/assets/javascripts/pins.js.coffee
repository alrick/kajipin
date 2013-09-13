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

  # PUBLIC : Filter pins list
  gon.filter_list_pins = (type, state) ->
    type = "."+type+"-type"
    list = $("#pins")
    if state
      list.find(type).fadeIn()
    else
      list.find(type).fadeOut()

  # PUBLIC : Adjust popup of pins size
  gon.adjust_popup_size = ->
    winWidth = $(window).width()
    winHeight = $(window).height()
    if winHeight > 795
      height = winHeight-450
      $(".photos").css("max-height", height)
      $(".comments").find(".inside").css("max-height", height-109)


  #################
  # TRIGGERS
  #################

  # Locate a pin when click from dropdown
  $(".pins").on "click", "a", ->
    gon.locate_pin.call(this, gon.map)


  #################
  # FLOW
  #################

  # Add pins tip if needed
  if !gon.hasPins
    $("#pin-initiator").tooltip "show"
    $("#pin-initiator-tooltip").closest(".tooltip").css({"font-size": "14px", "font-weight": "bold", "left": "", "right": "43px"})