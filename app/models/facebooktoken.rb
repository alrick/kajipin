class Facebooktoken < Accesstoken
  def fancy_name
    "Facebook"
  end

  def logo
    "facebook.png"
  end

  def self.description
    "Allows you to search for friends."
  end
end