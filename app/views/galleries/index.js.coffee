# Modal specific vars
width = 1000
path = "<%= j(render('galleries/gallery')) %>"
btn = "#map-gallerymodalbtn"

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModal .modal-header").html("<%= j(render('users/pin_modal_header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('users/pin_modal_footer')) %>")
$(btn).button("toggle")
$("#pinModal").modal()