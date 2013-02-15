$("#userModal .modal-body").html("<%= j(render('users/body')) %>")
$("#userModal .modal-footer").html("<%= j(render('users/footer')) %>")
$("#userModal").modal()

#replace text for sharing/unshare, need to be reloaded
$(".btn-unsocial").hoverIntent(
  -> $(this).html("Unshare").addClass("btn-remove"),
  -> $(this).html("<i class=\"icon-heart\"></i>&nbsp;&nbsp;Sharing").removeClass("btn-remove")
)