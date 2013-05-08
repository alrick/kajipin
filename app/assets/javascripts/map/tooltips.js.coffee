jQuery ->

  #################
  # FUNCTIONS
  #################

  # Allow to enable all zooming and paning
  gon.build_tooltip = (feature) ->
    tooltipTitle = '<h2>' + feature.properties.title + '</h2>'
    tooltipCountry = '<h3>' + feature.properties.country_name + '</h3>'
    photosBtn = $('<button class="btn btn-small btn-tool modal-open">' + feature.properties.photos_count + ' <i class="icon-camera-retro"></i></button>').click(->
      $.get(feature.properties.photos_path)
    )
    commentsBtn = $('<button class="btn btn-small btn-tool modal-open">' + feature.properties.comments_count + ' <i class="icon-comments"></i></button>').click(->
      $.get(feature.properties.comments_path)
    )
    logpagesBtn = $('<button class="btn btn-small btn-tool modal-open">' + feature.properties.logpages_count + ' <i class="icon-book"></i></button>').click(->
      $.get(feature.properties.logpages_path)
    )
    btnGroup = $('<div class="btn-group"></div>').append(photosBtn).append(commentsBtn).append(logpagesBtn)
    o = $('<div class="pin-tooltip"></div>').append(tooltipTitle).append(tooltipCountry).append(btnGroup)[0]