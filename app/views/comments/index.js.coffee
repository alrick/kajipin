$("#pinModal .modal-body").html("<%= j(render('users/show/pin_modal_commentsbody')) %>")
$("#pinModalLabel").html("<%= j(render('users/show/pin_modal_header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('users/show/pin_modal_footer')) %>")
$("#map-commentsmodalbtn").button("toggle")
$("#pinModal").animate({ width: "560px", marginLeft: "-280px" })
#$("#pinModal").width(560).css("margin-left", "-280px")
$("#pinModal").modal()