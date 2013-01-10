<% if @logpage.new_record? %>
  # Highlight in red the incorrect fields, if no incorrect field, highlight both
  if !$("#addLogpageModal input#logpage_title").val() && !$("#addLogpageModal textarea#logpage_content").val()
    $("#addLogpageModal input#logpage_title").effect("highlight", { color: "#5F1818" })
    $("#addLogpageModal textarea#logpage_content").effect("highlight", { color: "#5F1818" })
  else if !$("#addLogpageModal input#logpage_title").val()
    $("#addLogpageModal input#logpage_title").effect("highlight", { color: "#5F1818" })
  else if !$("#addLogpageModal textarea#logpage_content").val()
    $("#addLogpageModal textarea#logpage_content").effect("highlight", { color: "#5F1818" })
  else
    $("#addLogpageModal input#logpage_title").effect("highlight", { color: "#5F1818" })
    $("#addLogpageModal textarea#logpage_content").effect("highlight", { color: "#5F1818" })
<% else %>
  # Hide modal and clear inputs
  $("#addLogpageModal").modal("hide")
  $("#addLogpageModal input#logpage_title").val("")
  $("#addLogpageModal textarea#logpage_content").val("")

  # Scroll to bottom. add page and highlight
  $("html, body").animate { scrollTop: $(document).height() }, "slow"
  $("#logpages").append("<%= escape_javascript(render @logpage) %>")
  $("#<%= dom_id(@logpage) %>").delay(100).effect("highlight", { color: "#5F1818" })
<% end %>