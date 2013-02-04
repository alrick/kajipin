<% if !@logpage.errors.empty? %>
  # Hightlight the field if failed
  if !$("#<%= dom_id(@logpage) %> .logpage-form #logpage_title").val() && !$("#<%= dom_id(@logpage) %> .logpage-form #logpage_content").val()
    $("#<%= dom_id(@logpage) %> .logpage-form #logpage_title").effect("highlight", { color: "#5F1818" })
    $("#<%= dom_id(@logpage) %> .logpage-form #logpage_content").effect("highlight", { color: "#5F1818" })
  else if !$("#<%= dom_id(@logpage) %> .logpage-form #logpage_title").val()
    $("#<%= dom_id(@logpage) %> .logpage-form #logpage_title").effect("highlight", { color: "#5F1818" })
  else if !$("#<%= dom_id(@logpage) %> .logpage-form #logpage_content").val()
    $("#<%= dom_id(@logpage) %> .logpage-form #logpage_content").effect("highlight", { color: "#5F1818" })
  else
    $("#<%= dom_id(@logpage) %> .logpage-form #logpage_title").effect("highlight", { color: "#5F1818" })
    $("#<%= dom_id(@logpage) %> .logpage-form #logpage_content").effect("highlight", { color: "#5F1818" })

<% else %>
  # Update logpage view and form
  $("#<%= dom_id(@logpage) %>").html("<%= j(render('logpages/captain_logpage', :logpage => @logpage)) %>")

  # Switch, hide form and show view
  $("#<%= dom_id(@logpage) %> .logpage-view").css("display", "block")
  $("#<%= dom_id(@logpage) %> .logpage-form").css("display", "none")

  # Hightlight the logpage updated
  $("#<%= dom_id(@logpage) %>").effect("highlight", { color: "#D7CBC1" })
<% end %>