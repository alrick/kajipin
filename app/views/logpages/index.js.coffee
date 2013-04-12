# Modal specific vars
width = 990
path = "<%= j(render('logpages/logpages')) %>"
btn = "#map-logbookmodalbtn"

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModal .modal-header").html("<%= j(render('pins/header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('pins/footer')) %>")
$(btn).button("toggle")
$("#pinModal").modal()