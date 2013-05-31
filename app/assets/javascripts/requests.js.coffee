jQuery ->

  #################
  # TRIGGERS
  ################# 

  # Update requests box when modal is closed
  $("#reqModal").on "hide", ->
    if ($("#requests .request").length < 1)
      $("#requests-box").removeClass("active")
    else
      $("#requests-box").addClass("active")