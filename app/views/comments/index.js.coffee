# Modal specific vars
width = 560
path = "<%= j(render('comments/comments')) %>"
btn = "#map-commentsmodalbtn"

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModalLabel").html("<%= j(render('users/show/pin_modal_header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('users/show/pin_modal_footer')) %>")
$(btn).button("toggle")
$("#pinModal").modal()