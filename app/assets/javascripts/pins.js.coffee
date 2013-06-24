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
    $("#pins").find(".stats").find(".pins-count").html pinsCount

  # Refresh the cities count at top of pins sidebar
  refresh_cities = (cityCount) ->
    $("#pins").find(".stats").find(".city-count").html cityCount

  # Refresh the towns count at top of pins sidebar
  refresh_towns = (townCount) ->
    $("#pins").find(".stats").find(".town-count").html townCount

  # Refresh the poi count at top of pins sidebar
  refresh_poi = (poiCount) ->
    $("#pins").find(".stats").find(".poi-count").html poiCount

  # Resize modal depending on screen size
  modal_resize = ->
    doc_height = $(document).height()
    if doc_height > 800
      max_height = doc_height - 350 + "px"
      $(this).children(".modal-body").css "max-height", max_height
    else
      $(this).children(".modal-body").css "max-height", "400px"


  #################
  # FLOW
  #################

  # Check that we're on correct page (index pin page)
  if ($("#pins-toolstabs").length > 0)
    # Display correct tab
    if (gon.tab == "s")
      $("#pins-toolstabs a[href=\"#town\"]").tab("show")
    else if (gon.tab == "p")
      $("#pins-toolstabs a[href=\"#pointofinterest\"]").tab("show")


  # Check that we're on correct page (add pin page)
  if ($(".pins-addthis").length > 0)
    # Get type of pin from radio
    $(".pins-addthis").click ->
      addi = $("#pins-types .btn.active").attr("value")
      href = this.href
      if (href.indexOf("?") != -1)
        href = href + "&type=" + addi
      else
        href = href + "?type=" + addi
      $(this).attr("href", href)


  #################
  # TRIGGERS
  #################

  # Adjust modal height with size of document for big resolutions and switch interaction
  $("#pinModal").on "show", ->
    modal_resize.call(this)
    gon.disable_interaction gon.map
  $("#pinModal").on "hide", ->
    gon.enable_interaction gon.map