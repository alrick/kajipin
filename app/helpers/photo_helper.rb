module PhotoHelper
  
  def gravatar_link(email, size)
    gravatar_hash = Digest::MD5.hexdigest(email)
    # s = size, d = default avatar, r = rating (g for any audience type)
    "http://gravatar.com/avatar/#{gravatar_hash}?s=#{size}&d=mm&r=g"
  end

  def fp_link(url, width, height, fit)
    "#{url}/convert?w=#{width}&h=#{height}&fit=#{fit}"
  end

  def avatar_link(user, size)
    if user.nil?
      gravatar_link("no_user@kajipin.com", size)
    elsif user.avatar.nil?
      gravatar_link(user.email.downcase, size)
    else
      fp_link(user.avatar.url, size, size, "crop")
    end
  end
end