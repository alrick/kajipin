# Modal specific vars
path = "<%= j(render('requests/requests')) %>"

# Update content
$("#reqModal .modal-body").html(path)
$("#reqModal").modal()