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
end
