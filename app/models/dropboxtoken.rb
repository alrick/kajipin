class Dropboxtoken < Accesstoken
  def fancy_name
    "Dropbox"
  end

  def logo
    "dropbox.png"
  end

  def self.description
    "Allows you to add galleries to your pins."
  end
end