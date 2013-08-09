jQuery ->

  #################
  # FUNCTIONS
  #################

  # PUBLIC : Allow to enable all zooming and paning
  gon.build_popup = (feature) ->
    title = '<div class="page-header"><h2>' + feature.properties.title + ' <small>' + feature.properties.country_name + '</small></h2></div>'
    inside = $('<div class="inside"></div>')
    photos = $('<ul class="photos"></ul>')
    comments = $('<div class="comments"></div>')
    for photo in feature.photos
      photos.append('<a href="' + photo.get_big + '" class="mfp-image"><img alt="" class="img-polaroid" data-id="' + photo.id + '" src="' + photo.get_mini + '"></a>')
    for comment in feature.comments
      comments.append('<p>' + comment.value + '</p>')
    inside.append(photos).append(comments)
    o = $('<div class="popup"></div>').append(title).append(inside)[0]

  # PUBLIC : Set gallery for popup
  gon.init_mfp_gallery = ->
    $('.popup').magnificPopup
      key: "pin-photos"
      preload: [0,2]
      delegate: "a"
      gallery:
        enabled: true