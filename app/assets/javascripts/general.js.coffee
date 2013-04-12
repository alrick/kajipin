jQuery ->

  # Set tooltip integration
  $("a[rel~=tooltip]").tooltip()

  # Updage background on not looged in pages
  if $(".notlogged-title").length > 0
    $("body").css("background", "#4A4356")

  # Update inbox when modal is closed
  $("#reqModal").on "hide", ->
    if ($("#requests .request").length < 1)
      $("#inbox").removeClass("active-inbox")
    else
      $("#inbox").addClass("active-inbox")

  # Auto fade alert-success alert after a delay
  if $(".notlogged-title").length < 1
    $(".alert-success").delay(3000).fadeOut "slow"

  # Check that we're on correct page (user profile or friendships)
  if $(".userbox").length > 0
    #replace text for sharing/unshare
    $(".btn-unsocial").hoverIntent(
      -> $(this).html("Unshare").addClass("btn-remove"),
      -> $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass("btn-remove")
    )

  # Use bootstrap modal for confirmations
  $.rails.allowAction = (link) ->
    return true unless link.attr("data-confirm")
    $.rails.showConfirmDialog(link) # look bellow for implementations
    false # always stops the action since code runs asynchronously

  $.rails.confirmed = (link) ->
    # Display loading modal if set
    loading = link.data "loading"
    if loading
      loadingModal = $("#loadingModal")
      loadingModal.find("h3").html(loading)
      loadingModal.modal()
    link.removeAttr("data-confirm")
    link.trigger("click.rails")

  $.rails.showConfirmDialog = (link) ->
    message = link.data "confirm"
    beware = link.data "beware"
    html = """
            <div class="modal" id="confirmationDialog">
              <div class="modal-header">
                <h3>#{message}</h3>
              </div>
            """
    if beware
      html = html + """
             <div class="modal-body">
                <strong>Beware :</strong>
                <ul>
                  #{beware}
                </ul>
             </div>
             """
    html = html + """
              <div class="modal-footer">
                <a data-dismiss="modal" class="btn btn-other">Cancel</a>
                <a data-dismiss="modal" class="btn btn-confirm confirm">Yes, I'm positively certain.</a>
              </div>
            </div>
            """
    $(html).modal()
    $("#confirmationDialog").on "click", ".confirm", ->
      $.rails.confirmed(link)