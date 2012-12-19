class Twittertoken < Accesstoken
  def fancy_name
    "Twitter"
  end

  def logo
    "twitter.png"
  end

  def self.description
    "Allows you to search for friends."
  end
end