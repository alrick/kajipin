jQuery ->
  # Check that we're on correct page
  if ($(".logpage-view").length > 0)

    # Edit link clicked, display the form and hide the view
    $(".btn-edit").click ->
      logpage = $(this).attr("data-logpage")
      $("div#"+logpage+" .logpage-view").css("display", "none")
      $("div#"+logpage+" .logpage-form").css("display", "block")

    # Cancel link clicked, display the view and hide the form
    $(".btn-cancel").click ->
      logpage = $(this).attr("data-logpage")
      $("div#"+logpage+" .logpage-view").css("display", "block")
      $("div#"+logpage+" .logpage-form").css("display", "none")