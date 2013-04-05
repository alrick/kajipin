#################
# CONSTANTS
#################
WIDTH = 990
PHOTOS_PATH = "<%= j(render('photos/photos')) %>"
BIG_PHOTO_PATH = "<%= j(render('photos/big_photos')) %>"
PREV_KEY = 37
NEXT_KEY = 39
ESC_KEY = 27


#################
# FUNCTIONS
#################
# Function to check if it's first photo
isFirst = (p) ->
  first = $("#photoModal").find(".photo").first()
  p.data("id") == first.data("id")

# Function to check if it's last photo
isLast = (p) ->
  last = $("#photoModal").find(".photo").last()
  p.data("id") == last.data("id")

# Function to set photo as active
setActive = (p) ->
  p.addClass "active"
  photoModalAdjust(p)

# Function to switch active between two photos
switchActive = (old, photo) ->
  old.removeClass "active"
  setActive(photo)

# Function to resize the photoModal
photoModalAdjust = (p) ->
  photoModal = $("#photoModal")
  left_sign = photoModal.find(".icon-angle-left")
  right_sign = photoModal.find(".icon-angle-right")
  photoModal.css "margin-left", -(photoModal.width()/2)
  if isFirst(p)
    left_sign.hide()
  else
    left_sign.show()
  if isLast(p)
    right_sign.hide()
  else
    right_sign.show()

# Function to hide active photo and show prev
prevPhoto = ->
  photoModal = $("#photoModal")
  active = photoModal.find ".active"
  left_sign = photoModal.find(".icon-angle-left")
  if !isFirst(active)
    switchActive(active, active.prev(".photo"))

# Function to hide active photo and show next
nextPhoto = ->
  photoModal = $("#photoModal")
  active = photoModal.find ".active"
  right_sign = photoModal.find(".icon-angle-right")
  if !isLast(active)
    switchActive(active, active.next(".photo"))

# Function to hide pin modal properly and show big photo and his container from photo clicked
showBigPhoto = ->
  backdrop = $(".modal-backdrop")
  backdrop.off "click"
  backdrop.on "click", closeBigPhoto
  $("#pinModal").addClass "behind-backdrop"
  photoModal = $("#photoModal")
  bigPhoto = photoModal.find("[data-id='" + $(this).data("id") + "']")
  setActive(bigPhoto)
  photoModal.fadeIn()

# Function to close the big photo modal
closeBigPhoto = ->
  pinModal = $("#pinModal")
  $("#photoModal").fadeOut ->
    $(this).find(".active").removeClass("active")
    pinModal.removeClass("behind-backdrop")
    $(".modal-backdrop").on "click", ->
      pinModal.modal "hide"


#################
# FLOW
#################
# Resizing modal and loading photos
pinModal = $("#pinModal")
pinModal.animate({ width: WIDTH+"px", marginLeft: "-"+(WIDTH/2)+"px" })
pinModal.find(".modal-body").html PHOTOS_PATH
pinModal.find(".modal-header").html "<%= j(render('pins/header')) %>"
pinModal.find(".modal-footer").html "<%= j(render('pins/footer')) %>"
pinModal.find("#map-photosmodalbtn").button "toggle"
$("#pinModal").modal()

# Load big photos in background
$("#photoModal").html BIG_PHOTO_PATH


#################
# TRIGGERS
#################
# Trigger clicks on photos
$("#photos").on "click", ".photo", showBigPhoto
  
# Trigger clicks on prev button
$("#photoModal").on "click", ".icon-angle-left", prevPhoto

# Trigger clicks on next button
$("#photoModal").on "click", ".icon-angle-right", nextPhoto

# Trigger clicks on keyboard prev or next (only if photoModal)
$("body").keydown (e) ->
  if $("#photoModal").is(":visible")
    if e.which is PREV_KEY
      prevPhoto()
    if e.which is NEXT_KEY
      nextPhoto()
    if e.which is ESC_KEY
      closeBigPhoto()