jQuery ->
  # Check that we're on correct page
  if ($(".logpage-view").length > 0)

    # Edit link clicked, display the form and hide the view
    $(document).on "click", ".btn-edit", ->
      logpage = $(this).attr("data-logpage")
      $("#"+logpage+" .logpage-view").css("display", "none")
      $("#"+logpage+" .logpage-form").css("display", "block")