<% if @logpage.new_record? %>
  # Switch, hide form and show view
  $("#<%= dom_id(@logpage) %> .logpage-view").css("display", "block")
  $("#<%= dom_id(@logpage) %> .logpage-form").css("display", "none")

  # Hightlight the logpage failed
  $("#<%= dom_id(@logpage) %>").effect("highlight", { color: "#5F1818" })

<% else %>
  # Update title and content of view
  $("#<%= dom_id(@logpage) %> .logpage-view h2").html("<%= @logpage.title %>")
  $("#<%= dom_id(@logpage) %> .logpage-view p.lead").html("<%= @logpage.content %>")

  # Switch, hide form and show view
  $("#<%= dom_id(@logpage) %> .logpage-view").css("display", "block")
  $("#<%= dom_id(@logpage) %> .logpage-form").css("display", "none")

  # Hightlight the logpage updated
  $("#<%= dom_id(@logpage) %>").effect("highlight", { color: "#D7CBC1" })
<% end %>