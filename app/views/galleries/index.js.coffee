# Modal specific vars
width = 1000
path = "<%= j(render('galleries/galleries')) %>"
btn = "#map-galleriesmodalbtn"

# Calculate height
$("#calculator").html(path)
height = 560
cHeight = $("#calculator").height()
height = cHeight if cHeight < 560
$("calculator").html("")

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").animate({ height: height+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModalLabel").html("<%= j(render('users/show/pin_modal_header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('users/show/pin_modal_footer')) %>")
$(btn).button("toggle")
$("#pinModal").modal()