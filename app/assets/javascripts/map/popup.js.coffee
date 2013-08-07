jQuery ->

  #################
  # FUNCTIONS
  #################

  # Allow to enable all zooming and paning
  gon.build_popup = (feature) ->
    title = '<div class="page-header"><h2>' + feature.properties.title + ' <small>' + feature.properties.country_name + '</small></h2></div>'
    comments = ''
    for comment in feature.comments
      comments += '<p>' + comment.value + '</p>'
    o = $('<div class="popup"></div>').append(title).append(comments)[0]