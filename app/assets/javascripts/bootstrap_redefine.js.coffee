jQuery ->

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