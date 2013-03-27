jQuery ->

  # Trigger clicks on photos
  $("#cphotos").on "click", ".cphoto", ->

    $(this).find(".img-polaroid").toggleClass("selected") # Toggle img class
    checkbox = $(this).find("input[type=checkbox]") # Get the checkbox
    checkbox.prop "checked", not checkbox.prop("checked") # Toggle checkbox

    number_selected = $(".selected").length # Get number of selected photos
    selected_box = $("#selected-box") # Get the selected box
    
    # Fade in the selected box if at least 1 photo is selected, else fade out
    if number_selected > 0
      selected_box.fadeIn()
    else
      selected_box.fadeOut()

    selected_box.find("span").html(number_selected) # Update number of selected

  # Trigger form submit
  $("#cphotos-form").on "click", "button", ->
    $(this).button "loading"