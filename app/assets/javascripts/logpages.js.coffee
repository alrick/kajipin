jQuery ->
  # Check that we're on correct page
  if ($(".logpage-view").length > 0)

    # Edit link clicked, display the form and hide the view
    $(document).on "click", ".btn-edit", ->
      logpage = $(this).attr("data-logpage")
      $("#"+logpage+" .logpage-view").css("display", "none")
      $("#"+logpage+" .logpage-form").css("display", "block")

    # Cancel link clicked, display the view and hide the form
    $(document).on "click", ".btn-cancel", ->
      logpage = $(this).attr("data-logpage")
      logpage_title = $("#"+logpage+" .logpage-view .title").html()
      logpage_content = $("#"+logpage+" .logpage-view .content").html()
      $("#"+logpage+" .logpage-view").css("display", "block")
      $("#"+logpage+" .logpage-form").css("display", "none")
      $("#"+logpage+" .logpage-form #logpage_title").val(logpage_title)
      $("#"+logpage+" .logpage-form #logpage_content").val(logpage_content)