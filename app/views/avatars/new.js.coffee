filepicker.setKey "<%= @key %>"
filepicker.pickAndStore({services: ["DROPBOX", "FACEBOOK", "INSTAGRAM", "FLICKR", "GOOGLE_DRIVE", "BOX", "PICASA"]}, {}, (fpfile) ->
  # Create avatar object
  avatar = new Object()
  avatar.url = fpfile[0].url
  avatar.key = fpfile[0].key
  avatar.size = fpfile[0].size
  # Ajax request to add the photos
  $.ajax
    url: "<%= avatars_url %>"
    type: "POST"
    contentType: "application/json"
    data: JSON.stringify(avatar: avatar)
).fail ->
  $(".fp-fail").fadeIn()