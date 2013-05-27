# Modal specific vars
width = 560
path = "<%= j(render('comments/comments')) %>"

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModal .modal-header").html("<%= j(render('pins/header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('pins/footer')) %>")
$("#pinModal").find(".modal-footer").find(".comments").button "toggle"
$("#pinModal").modal()

# Init delete tooltip
$("a[rel=delete-tooltip]").tooltip(
  html: true
  placement: "left"
  trigger: "click"
).on("show", (e) ->
  e.stopPropagation()
).on "hide", (e) ->
  e.stopPropagation()