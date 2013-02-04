# Update logpage view and form
$("#<%= dom_id(@logpage) %>").html("<%= j(render('logpages/captain_logpage', :logpage => @logpage)) %>")

# Switch, hide form and show view
$("#<%= dom_id(@logpage) %> .logpage-view").css("display", "block")
$("#<%= dom_id(@logpage) %> .logpage-form").css("display", "none")