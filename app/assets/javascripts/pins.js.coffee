jQuery ->

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