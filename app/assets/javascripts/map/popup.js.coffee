jQuery ->

  #################
  # FUNCTIONS
  #################

  # Init gallery when popup set
  init_mfp_gallery = ->
    $('.photos').magnificPopup
      key: "pin-photos"
      preload: [0,2]
      delegate: "a"
      gallery:
        enabled: true

  # Retrieve pin view and set the popup
  gon.build_popup = (layer, feature) ->
    $.get("/pins/" + feature.id, (data) ->
      layer.setPopupContent(data)
      init_mfp_gallery()
    )