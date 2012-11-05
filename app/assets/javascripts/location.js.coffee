jQuery ->
  # Check that we're on correct page
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

  # Check that we're on correct page
  if ($("#pins-locategoryedit").length > 0)

    # Change hidden value
    $(".pins-locategorybtn").click ->
      val = $(this).attr("value")
      $("#pins_locategory_id").attr("value", val)