jQuery ->

  #################
  # FUNCTIONS
  #################

  # Allow to enable all zooming and paning
  gon.build_tooltip = (feature) ->
    tooltipTitle = '<h2>' + feature.properties.title + '</h2>'
    tooltipCountry = '<h3>' + feature.properties.country_name + '</h3>'
    tooltipPhotos = '<a href="' + feature.properties.photos_path + '" class="btn btn-small btn-tool modal-open" data-remote="true">' + feature.properties.photos_count + '&nbsp;<i class="icon-camera-retro"></i></a>'
    tooltipComments = '<a href="' + feature.properties.comments_path + '" class="btn btn-small btn-tool modal-open" data-remote="true">' + feature.properties.comments_count + '&nbsp;<i class="icon-comments"></i></a>'
    tooltipLogbook = '<a href="' + feature.properties.logpages_path + '" class="btn btn-small btn-tool modal-open" data-remote="true">' + feature.properties.logpages_count + '&nbsp;<i class="icon-book"></i></a>'
    o = '<div class="pin-tooltip">' + tooltipTitle + tooltipCountry + '<div class="btn-group">' + tooltipPhotos + tooltipComments + tooltipLogbook + '</div></div>'