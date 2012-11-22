$("#commentsModal .modal-body").html("<%= j(render('users/show/comments', :comments => @comments)) %>")
$('#commentsModal').modal()