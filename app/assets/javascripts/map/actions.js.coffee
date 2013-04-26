# Hide or show pins of the layer passed in param
gon.toggle_action = (layer) ->
  icon = $(this).find("i").toggleClass "icon-eye-open icon-eye-close"
  layer.setFilter (f) ->
    icon.hasClass "icon-eye-open"