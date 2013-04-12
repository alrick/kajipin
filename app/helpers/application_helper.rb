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

end
