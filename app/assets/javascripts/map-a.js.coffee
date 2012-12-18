jQuery ->
  # Check that we're on correct page
  if ($("#map").length > 0)

    #########################################
    #### INITIALISATION
    #########################################

    # Map init
    map = mapbox.map("map")
    map.addLayer(mapbox.layer().id("alrick.map-y17w9hkl", () ->
      map.ui.refresh()))

    # Map config
    map.zoom(3)
    map.center({ lat: 24.06, lon: 13.33 })
    map.ui.attribution.add()
    map.ui.zoombox.add()
    map.ui.zoomer.add()
    map.setZoomRange(3, 17)

    # Only if user has pins to diplay
    if gon.pins and gon.pins.length > 0
      # Create all empty markers layer & group vars
      pinsLayer = mapbox.markers.layer()

      # Add all pin of the user into the right layer
      pinsLayer.features(gon.pins)

      # Add interaction to this marker layers (title and description)
      interaction = mapbox.markers.interaction(pinsLayer)

      # Add layers to the map
      map.addLayer(pinsLayer)

      # Define formater for pins tooltips
      interaction.formatter (feature) ->
        tooltipTitle = '<h2 class="map-tooltiptitle">' + feature.properties.title + '</h2>'
        tooltipCountry = '<h3 class="map-tooltipcountry">' + feature.properties.country_name + '</h3>'
        tooltipGalleries = '<a href="' + feature.properties.galleries_path + '" class="btn btn-small btn-tool map-tooltipbtn map-modalopen map-modalresizebig" data-remote="true">' + feature.properties.galleries_count + '&nbsp;<i class="icon-camera"></i></a>&nbsp;'
        tooltipComments = '<a href="' + feature.properties.comments_path + '" class="btn btn-small btn-tool map-tooltipbtn map-modalopen map-modalresizesmall" data-remote="true">' + feature.properties.comments_count + '&nbsp;<i class="icon-comment"></i></a>'
        tooltipLogbook = '<a href="#" class="btn btn-small btn-tool map-tooltipbtn map-modalopen map-modalresizesmall">' + feature.properties.logpages_count + '&nbsp;<i class="icon-book"></i></a>&nbsp;'
        tooltipZoom = '<a onclick="gon.map.centerzoom({ lat: ' + feature.geometry.coordinates[1] + ', lon: ' + feature.geometry.coordinates[0] + ' }, 12, true)" class="btn btn-small btn-map map-tooltipbtn map-tooltipzoom" data-lat="' + feature.geometry.coordinates[1] + '" data-lon="' + feature.geometry.coordinates[0] + '"><i class="icon-zoom-in"></i></a>'
        o = '<div style="text-align:center">' + tooltipTitle + tooltipCountry + '<div>' + tooltipGalleries + tooltipComments + '</div><div>' + tooltipLogbook + tooltipZoom + '</div></div>'

      # By default, the map extent markers
      map.extent(pinsLayer.extent())
      
    # Else display a little message
    else
      $("#map-infocenter").css("display", "block")

    # Set intent if pin selected
    if (gon.plat && gon.plon)
      map.centerzoom({ lat: gon.plat, lon: gon.plon }, 12)

    # Export map and pinsLayer for subsequent treatments
    gon.map = map
    gon.pinsLayer = pinsLayer