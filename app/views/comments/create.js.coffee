<% if @comment.new_record? %>
  $("textarea#comment_value").effect("highlight", { color: "#5F1818" })
<% else %>
  $("div#comments").append("<%= escape_javascript(render @comment) %>")
  $("div#<%= dom_id(@comment) %>").effect("highlight", { color: "#D7CBC1" })
  $("textarea#comment_value").val("")
  
  if ($("#comments .empty-set").length > 0)
    $("#comments .empty-set").remove()
<% end %>