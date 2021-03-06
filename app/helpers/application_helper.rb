module ApplicationHelper

  def sharing_btn(user)
    if @herald.nil?
      unless user == current_user
        if current_user.isSharingWith(user)
          friendship = current_user.friendships.where(:friend_id => user.id).first
          link_to content_tag("i", "", :class => "icon-heart")+" Sharing", friendship_path(friendship), :method => :delete, :remote => true, :class => "btn btn-social btn-unsocial sharing-btn #{user.id}"
        else
          link_to "Share", friendships_path(:friend => user), :method => :post, :remote => true, :class => "btn btn-social sharing-btn #{user.id}"
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

  def share_request
    if Request.where(:user_id => @user.id, :requester_id => current_user.id).exists?
      link_to "Request sent", "#", :class => "btn btn-social disabled"
    else
      link_to "Request", requests_path(:user => @user, :requester => current_user), :method => :post, :class => "btn btn-social"
    end
  end

  def proper_date(date)
    date.to_formatted_s(:long_ordinal)
  end

  def pin_class(type)
    type.downcase
  end
  
end