# Modal specific vars
path = "<%= j(render('tabs')) %>"

# Update content
$("#listModal .modal-body").html(path)
$("#listModal").modal()

# Hide modal when btn clicked
$(".btn-list").click ->
  $("#listModal").modal("hide")