<% if @logpage.new_record? %>
  # Highlight in red the incorrect fields, if no incorrect field, highlight both
  if !$("#addLogpageModal #logpage_title").val() && !$("#addLogpageModal #logpage_content").val()
    $("#addLogpageModal #logpage_title").effect("highlight", { color: "#5F1818" })
    $("#addLogpageModal #logpage_content").effect("highlight", { color: "#5F1818" })
  else if !$("#addLogpageModal #logpage_title").val()
    $("#addLogpageModal #logpage_title").effect("highlight", { color: "#5F1818" })
  else if !$("#addLogpageModal #logpage_content").val()
    $("#addLogpageModal #logpage_content").effect("highlight", { color: "#5F1818" })
  else
    $("#addLogpageModal #logpage_title").effect("highlight", { color: "#5F1818" })
    $("#addLogpageModal #logpage_content").effect("highlight", { color: "#5F1818" })
<% else %>
  # Hide modal and clear inputs
  $("#addLogpageModal").modal("hide")
  $("#addLogpageModal #logpage_title").val("")
  $("#addLogpageModal #logpage_content").val("")

  # Scroll to bottom. add page and highlight
  $("html, body").animate { scrollTop: $(document).height() }, "slow"
  $("#logpages").append("<%= escape_javascript(render @logpage) %>")
  $("#<%= dom_id(@logpage) %>").delay(100).effect("highlight", { color: "#5F1818" })
<% end %>