# Modal specific vars
path = "<%= j(render('heralds/heralds')) %>"

# Update content
$("#heraldModal .modal-body").html(path)

# Init delete tooltip
$("a[rel=delete-tooltip]").tooltip(
  html: true
  placement: "left"
  trigger: "click"
).on("show", (e) ->
  e.stopPropagation()
).on "hide", (e) ->
  e.stopPropagation()