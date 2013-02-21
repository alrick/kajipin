jQuery ->
  # Check that we're on correct page
  if ($(".captain-logpages").length > 0)

    # Edit link clicked, display the form and hide the view
    $(".captain-logpages").on "click", ".btn-edit", ->
      logpage = $(this).attr("data-logpage")
      $("#"+logpage+" .logpage-view").css("display", "none")
      $("#"+logpage+" .logpage-form").css("display", "block")