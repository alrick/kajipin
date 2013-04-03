# Modal specific vars
width = 990
path = "<%= j(render('photos/photos')) %>"
btn = "#map-photosmodalbtn"

# Resizing and content
$("#pinModal").animate({ width: width+"px", marginLeft: "-"+(width/2)+"px" })
$("#pinModal .modal-body").html(path)
$("#pinModal .modal-header").html("<%= j(render('pins/header')) %>")
$("#pinModal .modal-footer").html("<%= j(render('pins/footer')) %>")
$(btn).button("toggle")
$("#pinModal").modal()

jQuery ->

  # Trigger clicks on photos
  $("#photos").on "click", ".mini", ->
    source = $(this).data("big")
    big = $('<img src="'+source+'" class="img-polaroid" alt="loading">')
    photoModal = $("#photoModal")
    photoModal.fadeIn()
    photoModal.append(big).fadeIn()
    $("#pinModal").css "z-index", "1000"
    $(".modal-backdrop").off("click")

  # Trogger clicks on big
  $("#photoModal").on "click", ->
    pinModal = $("#pinModal")
    photoModal = $(this)
    photoModal.fadeOut()
    photoModal.find(".img-polaroid").remove()
    pinModal.css "z-index", "1050"
    $(".modal-backdrop").on "click", ->
      pinModal.modal "hide"