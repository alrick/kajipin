# Modal specific vars
width = 1000
path = "<%= j(render('galleries/galleries')) %>"
btn = "#map-galleriesmodalbtn"

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModalLabel").html("<%= j(render('users/show/pin_modal_header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('users/show/pin_modal_footer')) %>")
$(btn).button("toggle")
$("#pinModal").modal()