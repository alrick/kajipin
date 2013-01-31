# Modal specific vars
path = "<%= j(render('tabs')) %>"

# Update content
$("#pinslistModal .modal-body").html(path)
$("#pinslistModal").modal()

# Hide modal when btn clicked
$(".btn-pinslist").click ->
  $("#pinslistModal").modal("hide")