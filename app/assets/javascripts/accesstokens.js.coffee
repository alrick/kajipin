jQuery ->
  # Check that we're on correct page
  if ($("#accesstokens-add").length > 0)
    
    #replace text when user click the add button
    $("#accesstokens-add").click ->
      $(this).children(".icon-plus-sign").attr("class", "icon-time")
      $(this).addClass("disabled")