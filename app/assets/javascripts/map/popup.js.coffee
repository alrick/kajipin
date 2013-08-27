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

  # Init delete tooltip
  init_delete_tooltip = ->
    $("a[rel=delete-tooltip]").tooltip(
      html: true
      placement: "left"
      trigger: "click"
    ).on("show", (e) ->
      e.stopPropagation()
    ).on "hide", (e) ->
      e.stopPropagation()

  # Retrieve pin view and set the popup
  gon.build_popup = (layer, feature, e) ->
    $.get("/pins/" + feature.id, (data) ->
      layer.setPopupContent(data)
      init_mfp_gallery()
      init_delete_tooltip()
      gon.map.panTo [gon.map.getCenter().lat, e.latlng.lng]
    )