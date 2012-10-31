jQuery ->
  # Auto fade alert-success alert after a delay
  $(".alert-success").delay(3000).fadeOut "slow", ->
    $(this).remove()