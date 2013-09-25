#################
# FUNCTIONS
#################

# PUBLIC : Init gallery when popup set
gon.init_mfp_gallery = ->
  $('.photos').magnificPopup
    key: "pin-photos"
    preload: [0,2]
    delegate: "a"
    gallery:
      enabled: true

# Function to update the selected box
update_selected = ->
  number_selected = $(".selected").length
  selected_box = $("#selected-box")
  if number_selected > 0
    selected_box.fadeIn()
  else
    selected_box.fadeOut()
  selected_box.find("span").html(number_selected)

# Function to select photos
select_photo = ->
  $(this).find(".img-polaroid").toggleClass "selected" # Toggle img class
  checkbox = $(this).find("input[type=checkbox]") # Get the checkbox
  checkbox.prop "checked", not checkbox.prop("checked") # Toggle checkbox
  update_selected()


#################
# TRIGGERS
#################

$(document).ready ->

  # Trigger clicks on photos (captain)
  $("#cphotos").on "click", ".cphoto", select_photo

  # Trigger form submit
  $("#cphotos-form").on "click", "button", ->
    $(this).button "loading"