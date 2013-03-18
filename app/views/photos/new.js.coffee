filepicker.setKey 'AJ2xVaRuBRF4Cp1vbZukAz'
filepicker.pickAndStore {multiple: true, services: ['DROPBOX', 'FACEBOOK', 'INSTAGRAM', 'FLICKR', 'GOOGLE_DRIVE', 'BOX', 'PICASA']}, {}, (fpfiles) ->
  # Create photo objects
  photos = new Array()
  i = 0
  while i < fpfiles.length
    photos[i] = new Object()
    photos[i].url = fpfiles[i].url
    i++
  # Ajax request to add the photos
  $.ajax(
    url: "<%= create_many_pin_photos_url(@pin) %>"
    type: "POST"
    contentType: "application/json"
    data: JSON.stringify(photos: photos)
  ).always ->
    location.reload()