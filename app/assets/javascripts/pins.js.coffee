jQuery ->

  # Check that we're on correct page (index pin page)
  if ($("#pins-toolstabs").length > 0)
    
    # Display correct tab
    if (gon.tab == "s")
      $("#pins-toolstabs a[href=\"#smallcity\"]").tab("show")
    else if (gon.tab == "p")
      $("#pins-toolstabs a[href=\"#pointofinterest\"]").tab("show")


  # Check that we're on correct page (add pin page)
  if ($(".pins-addthis").length > 0)

    # Add param for locategory
    $(".pins-addthis").click ->
      addi = $(".pins-locategorybtn.active").attr("value")
      $(".pins-addthis").each ->
        href = this.href
        if (href.indexOf("?") != -1)
          href = href + "&locategory=" + addi
        else
          href = href + "?locategory=" + addi
        $(this).attr("href", href)


  # Check that we're on correct page (edit pin page)
  if ($("#pins-locategoryedit").length > 0)

    # Change hidden value
    $(".pins-locategorybtn").click ->
      val = $(this).attr("value")
      $("#pin_locategory_id").attr("value", val)