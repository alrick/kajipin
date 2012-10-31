jQuery ->
  # Check that we're on correct page
  if ($(".location-addthis").length > 0)

    # Add param for locategory
    $(".location-addthis").click ->
      addi = $(".location-locategorybtn.active").attr("value")
      $(".location-addthis").each ->
        href = this.href
        if (href.indexOf("?") != -1)
          href = href + "&locategory=" + addi
        else
          href = href + "?locategory=" + addi
        $(this).attr("href", href)

  # Check that we're on correct page
  if ($("#location-locategoryedit").length > 0)

    # Change hidden value
    $(".location-locategorybtn").click ->
      val = $(this).attr("value")
      $("#location_locategory_id").attr("value", val)