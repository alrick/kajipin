jQuery ->

  # Check that we're on correct page
  if ($("#captain-photos").length > 0)

    # Init delete tooltips
    $("a[rel=delete-tooltip]").tooltip(html: true, placement: "left", trigger: "click")