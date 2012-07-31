module ApplicationHelper
  def gravatar_url(user, size)
    gravatar_hash = Digest::MD5.hexdigest(user.email.downcase)
    # s = size, d = default avatar, r = rating (g for any audience type)
    "http://gravatar.com/avatar/#{gravatar_hash}?s=#{size}&d=mm&r=g"
  end
end
