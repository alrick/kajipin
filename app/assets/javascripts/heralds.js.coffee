jQuery ->

  #################
  # TRIGGERS
  ################# 

  # Update herald box when modal is closed
  $("#heraldModal").on "hide", ->
    if $("#heralds").find("code").length
      $("#herald-box").addClass "active"
    else
      $("#herald-box").removeClass "active"