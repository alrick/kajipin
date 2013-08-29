# Modal specific vars
path = "<%= j(render('heralds/heralds')) %>"

# Update content
$("#heraldModal .modal-body").html(path)
$("#heraldModal").modal()

# Init delete tooltip
gon.init_delete_tooltip()