jQuery ->

  #################
  # FUNCTIONS
  #################

  # Center information block
  center_element = (element) ->
    padding = element.css("padding-top").replace("px", "")
    padding = padding*2
    height = element.height()
    topmargin = ((padding+height)/2) * -1
    element.css("margin-top", topmargin)


  #################
  # FLOW
  #################

  # Init achievements popover of user
  $(".info-user img").popover()

  # Center information block if present
  if $(".info-center").length
    center_element $(".info-center")