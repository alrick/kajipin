filepicker.setKey "<%= @key %>"
filepicker.pickAndStore({multiple: true, mimetype: 'image/*', services: ["DROPBOX", "FACEBOOK", "INSTAGRAM", "FLICKR", "GOOGLE_DRIVE", "BOX", "PICASA"]}, {}, (fpfiles) ->
  # Create photo objects
  photos = new Array()
  i = 0
  while i < fpfiles.length
    photos[i] = new Object()
    photos[i].url = fpfiles[i].url
    photos[i].key = fpfiles[i].key
    photos[i].size = fpfiles[i].size
    i++
  # Ajax request to add the photos
  $.ajax
    url: "<%= create_many_pin_photos_url(@pin) %>"
    type: "POST"
    contentType: "application/json"
    data: JSON.stringify(photos: photos)
).fail ->
  $(".fp-fail").fadeIn()