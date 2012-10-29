class Appetizer < ActiveRecord::Base
  # General
  def self.appname
    "Kajipin"
  end

  # Accesstokens types
  def self.dropbox_token
    "DROPBOX"
  end
  def self.twitter_token
    "TWITTER"
  end
  def self.facebook_token
    "FACEBOOK"
  end

  # Geonames config
  def self.geonames_maxrows
    "20"
  end
  def self.geonames_fuzzy
    "0.8"
  end
  def self.geonames_username
    "sloppin"
  end

  # Dropbox config
  def self.dropbox_appkey
    "ljdah1pozdpylvt"
  end
  def self.dropbox_appsecret
    "lp4raap85gu15dx"
  end
end