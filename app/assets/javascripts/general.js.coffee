jQuery ->
  $(".alert-success").delay(3000).fadeOut "slow", ->
    $(this).remove()