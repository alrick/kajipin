jQuery ->
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