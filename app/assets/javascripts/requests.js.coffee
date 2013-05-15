jQuery ->

  #################
  # TRIGGERS
  ################# 

  # Update inbox when modal is closed
  $("#reqModal").on "hide", ->
    if ($("#requests .request").length < 1)
      $("#inbox").removeClass("active-inbox")
    else
      $("#inbox").addClass("active-inbox")