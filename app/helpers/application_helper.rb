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

  def no_pin_element
    if @herald.nil? && @user == current_user
      content_tag(:p, "You have no pin!", :class => "lead")+
      link_to("Add some", pins_url, :class => "btn btn-map")
    else
      content_tag(:p, @user.first_name + " has no pin", :class => "lead no-margin")
    end
  end

  def tools_btn(pin, size, label)
    if @herald.nil?
      p_path = pin_photos_path(pin)
      c_path = pin_comments_path(pin)
      l_path = pin_logpages_path(pin)
    else
      p_path = photos_heralds_path(:key => @herald.key, :pin => pin)
      c_path = comments_heralds_path(:key => @herald.key, :pin => pin)
      l_path = logpages_heralds_path(:key => @herald.key, :pin => pin)
    end
    if label
      p_text = content_tag(:i, "", :class => "icon-camera-retro") + " Photos (" + pin.photos.count.to_s + ")"
      c_text = content_tag(:i, "", :class => "icon-comments") + " Comments (" + pin.comments.count.to_s + ")"
      l_text = content_tag(:i, "", :class => "icon-book") + " Logbook (" + pin.logpages.count.to_s + ")"
    else
      p_text = pin.photos.count.to_s + " " + content_tag("i", "", :class => "icon-camera-retro")
      c_text = pin.comments.count.to_s + " " + content_tag("i", "", :class => "icon-comments")
      l_text = pin.logpages.count.to_s + " " + content_tag("i", "", :class => "icon-book")
    end
    link_to(p_text.html_safe, p_path, :class => "photos btn btn-tool "+size, :remote => true)+
    link_to(c_text.html_safe, c_path, :class => "comments btn btn-tool "+size, :remote => true)+
    link_to(l_text.html_safe, l_path, :class => "logpages btn btn-tool "+size, :remote => true)
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