$("#pinModal .modal-body").html("<%= j(render('users/show/pin_modal_commentsbody')) %>")
$("#pinModalLabel").html("<%= j(render('users/show/pin_modal_header')) %>")
$("#pinModal").modal()
$("#map-commentsmodalbtn").button("toggle")