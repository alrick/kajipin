module ApplicationHelper

  def sharing_btn(user, size)
    if @herald.nil? # if isn't accessed via herald
      if user == current_user
        link_to "That's you!", "#", :class => "btn btn-social #{size}", :rel => "tooltip", :data => { :title => "Yeah really..", :placement => "left" }
      else
        if current_user.isSharingWith(user)
          friendship = current_user.friendships.where(:friend_id => user.id).first
          link_to content_tag("i", "", :class => "icon-heart")+" Sharing", friendship_path(friendship), :method => :delete, :remote => true, :class => "btn btn-social btn-unsocial #{size}"
        else
          link_to "Share", friendships_path(:friend => user), :method => :post, :remote => true, :class => "btn btn-social #{size}"
        end
      end
    end
  end

  def sharer_label(user)
    if user.isSharingWith(current_user)
      content_tag(:span, "Sharer", :class => "label label-social is-sharer")
    else
      content_tag(:span, "&nbsp;".html_safe)
    end
  end

  def toggler(layout)
    if layout == "map" && !@pins.nil?
      if !@pins.empty?
        content_tag(:button, content_tag(:i, "", :class => "icon-list"), :id => "toggler", :class => "btn btn-tool", :type => "button")
      end
    end
  end

end