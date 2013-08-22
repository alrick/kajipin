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
      comments.append('<div class="comment">' + 
        '<div class="avatar">' + 
          '<img src="' + comment.user.avatar + '" alt="" class="img-polaroid">' + 
        '</div>' + 
        '<div class="text">' +
          '<p>' +
            comment.value + 
          '</p>' + 
          '<small class="author">' + comment.user.full_name + '</small>' + 
          '<small class="datetime">(' + comment.date + ')</small>' + 
        '</div>'
      '</div>')
    inside.append(comments).append(photos)
    o = $('<div class="popup"></div>').append(title).append(inside)[0]

  # PUBLIC : Set gallery for popup
  gon.init_mfp_gallery = ->
    $('.popup').magnificPopup
      key: "pin-photos"
      preload: [0,2]
      delegate: "a"
      gallery:
        enabled: true