<% if @comment.new_record? %>
  $("textarea#comment_value").effect("highlight", { color: "#5F1818" })
<% else %>
	$("textarea#comment_value").val("")
	inside = $("div.comments").find(".inside")
	inside.append "<%= escape_javascript(render @comment) %>"
	inside.scrollTop(inside[0].scrollHeight)
	gon.init_delete_tooltip()
	gon.update_comments(<%= @comment.pin.id %>, <%= @comment.pin.comments.count %>)
<% end %>