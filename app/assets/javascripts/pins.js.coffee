jQuery ->
  # Check that we're on correct page
  if ($("#pins-toolstabs").length > 0)
    
    # Display correct tab
    if (gon.tab == "l")
      $('#pins-toolstabs a[href="#logbook"]').tab('show')
    else if (gon.tab == "c")
      $('#pins-toolstabs a[href="#comments"]').tab('show')