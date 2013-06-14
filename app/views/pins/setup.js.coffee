# Modal specific vars
path = "<%= j(render('pins/setup')) %>"

# Update content
$("#creatorModal").html(path)
$("#creatorModal").modal()