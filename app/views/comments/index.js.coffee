$("#pinModal .modal-body").html("<%= j(render('users/show/pin_modal_commentsbody', :comments => @comments, :comment => Comment.new, :pin => @pin)) %>")
$("#pinModalLabel").html("<%= j(render('users/show/pin_modal_header', :pin => @pin)) %>")
$("#pinModal").modal()
$("#map-commentsmodalbtn").button("toggle")