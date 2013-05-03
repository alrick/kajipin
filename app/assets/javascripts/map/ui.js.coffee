jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)

    # Center information block if present
    if ($(".info-center").length > 0)
      info_center = $(".info-center")
      padding = info_center.css("padding-top").replace("px", "")
      padding = padding*2
      height = info_center.height()
      topmargin = ((padding+height)/2) * -1
      info_center.css("margin-top", topmargin)

    # Update pins when modal is hide
    $("#pinModal").on "hide", ->
      gon.watch "pins", (pins) ->
        gon.pinsLayer.features(pins)

    # Adjust modal height with size of document for big resolutions
    $("#pinModal").on "show", ->
      doc = $(document).height()
      if doc > 800
        max_height = doc - 350 + "px"
        $(this).children(".modal-body").css "max-height", max_height
      else
        $(this).children(".modal-body").css "max-height", "400px"