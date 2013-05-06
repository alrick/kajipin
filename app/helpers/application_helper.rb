module ApplicationHelper

  def gravatar_url(user, size)
    if user.nil?
      email = "no_user@kajipin.com"
    else
      email = user.email.downcase
    end
    gravatar_hash = Digest::MD5.hexdigest(email)
    # s = size, d = default avatar, r = rating (g for any audience type)
    "http://gravatar.com/avatar/#{gravatar_hash}?s=#{size}&d=mm&r=g"
  end

  def fp_url(url, width, height, fit)
    "#{url}/convert?w=#{width}&h=#{height}&fit=#{fit}"
  end

  def avatar_url(user, size)
    if user.avatar.nil?
      gravatar_url(user, size)
    else
      fp_url(user.avatar.url, size, size, "crop")
    end
  end

  def sharing_btn(user, size)
    if user == current_user
      link_to "That's you!", "#", :class => "btn btn-social #{size}", :rel => "tooltip", :data => { :title => "Yeah really..", :placement => "left" }
    else
      if current_user.isSharingWith(user)
        friendship = current_user.friendships.where(:friend_id => user.id).first
        link_to content_tag("i", "", class: "icon-heart")+" Sharing", friendship_path(friendship), :method => :delete, :remote => true, :class => "btn btn-social btn-unsocial #{size}"
      else
        link_to "Share", friendships_path(:friend => user), :method => :post, :remote => true, :class => "btn btn-social #{size}"
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

end