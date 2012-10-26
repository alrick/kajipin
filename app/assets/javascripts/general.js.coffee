jQuery ->
  $(".alert").delay(3000).fadeOut "slow", ->
    $(this).remove()