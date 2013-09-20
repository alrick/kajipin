#################
# FLOW
#################

# Add backdrop and form to body
$("<%= j(render('pins/new')) %>").appendTo(document.body)


#################
# TRIGGERS
#################

# Bind the typeahead to form's input
typeA = $("#new-pin").find(".name")
typeA.typeahead
  name: "geonames"
  remote: "/geonames?q=%QUERY"
  valueKey: "name"
  limit: 50
  header: "<p class=\"geo-cc\"><strong>All data informations are provided by GeoNames under CC BY 2.5</strong></p>"
  footer: "<p class=\"geo-report\"><strong>Feel free to report missing places with the \"Feedback & Support\" tool.</strong></p>"
  allowDuplicates: true
  template: [
    "<p class=\"geo-type\">{{type}}</p>",
    "<p class=\"geo-name\"><strong>{{name}}</strong></p>",
    "<p class=\"geo-description\">{{region}}, {{country}}</p>"
  ].join("")
  engine: Hogan

# Bind the hider to backdrop
$(".modal-backdrop").click ->
  $("#new-pin").remove()

# Register event on item selection
typeA.on "typeahead:selected", (evt, data) ->
  $("#geoname_id").val(data.geoname_id)
  $("#new-pin-form").submit()

# Change type in hidden field when bootstrap buttons are clicked
$("#new-pin").on "click", ".type", ->
  $("#type").val($(this).val())