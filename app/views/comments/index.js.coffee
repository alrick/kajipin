# Modal specific vars
width = 560
path = "<%= j(render('comments/comments')) %>"
btn = "#map-commentsmodalbtn"

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModal .modal-header").html("<%= j(render('pins/header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('pins/footer')) %>")
$(btn).button("toggle")
$("#pinModal").modal()

# Init delete tooltips
$("a[rel=delete-tooltip]").tooltip(
  html: true
  placement: "left"
  trigger: "click"
).on("show", (e) ->
  e.stopPropagation()
).on "hide", (e) ->
  e.stopPropagation()