jQuery ->
  # Check that we're on correct page
  if ($("#home-map").length > 0)

    # Map init
    map = mapbox.map("home-map")
    map.addLayer(mapbox.layer().id("alrick.map-y17w9hkl", () ->
      map.ui.refresh()))

    # Map config
    map.zoom(3)
    map.center({ lat: 24.06, lon: 13.33 })
    map.ui.attribution.add()
    map.ui.zoombox.add()
    map.ui.zoomer.add()
    map.setZoomRange(3, 17)