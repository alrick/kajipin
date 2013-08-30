jQuery ->

  # http://rors.org/demos/custom-confirm-in-rails
  $.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link) # look bellow for implementations
    false # always stops the action since code runs asynchronously

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    gon.loading()
    link.trigger('click.rails')

  # Boostrap
  $.rails.showConfirmDialog = (link) ->
    message = link.attr 'data-confirm'
    html = """
           <div class="modal" id="confirmationDialog">
             <div class="modal-header">
               <a class="close" data-dismiss="modal">×</a>
               <h3>Are you sure?</h3>
             </div>
             <div class="modal-body">
               <div class="lead"><strong>Beware:</strong> #{message}</div>
             </div>
             <div class="modal-footer">
               <a data-dismiss="modal" class="btn btn-other">Cancel</a>
               <a data-dismiss="modal" class="btn btn-confirm confirm">Confirm</a>
             </div>
           </div>
           """
    $(html).modal()
    $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)