jQuery ->

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

  # Override Rails handling of confirmation
  $.rails.allowAction = (element) ->
    # The message is something like "Are you sure?"
    message = element.data('confirm')
    beware = element.data('beware')
    # If there's no message, there's no data-confirm attribute, 
    # which means there's nothing to confirm
    return true unless message
    # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
    $link = element.clone()
      # We don't necessarily want the same styling as the original link/button.
      .removeAttr('class')
      # We don't want to pop up another confirmation (recursion)
      .removeAttr('data-confirm')
      # data-dismiss property is required for remote links
      .attr('data-dismiss', 'modal')
      # We want a button
      .addClass('btn').addClass('btn-confirm')
      # We want it to sound confirmy
      .html("Yes, I'm positively certain.")

    # Create the modal box with the message
    modal_html = """
                 <div class="modal fade" id="myModal">
                   <div class="modal-header">
                     <h3>#{message}</h3>
                   </div>
                 """
    if beware
      modal_html = modal_html + """
                    <div class="modal-body">
                      <strong>Beware :</strong>
                      <ul>
                        #{beware}
                      </ul>
                    </div>
                  """
    modal_html = modal_html + """
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn btn-crud">Cancel</a>
                   </div>
                 </div>
                 """
    $modal_html = $(modal_html)
    # Add the new button to the modal box
    $modal_html.find('.modal-footer').append($link)
    # Pop it up
    $modal_html.modal()
    # Prevent the original link from working
    return false