jQuery ->
  #replace text for sharing/unshare
  $('.btn-unsocial').hover(
    -> $(this).text('Unshare'),
    -> $(this).text('Sharing')
  )