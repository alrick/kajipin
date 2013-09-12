#################
# FUNCTIONS
#################

# PUBLIC : Update comments counters
gon.update_comments = (pin_id, count) ->
  $(".comments-count."+pin_id).html(count)