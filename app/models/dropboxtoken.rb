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

  def self.dropbox_authorization
    dbsession = DropboxSession.new(Appetizer.dropbox_appkey, Appetizer.dropbox_appsecret) # init session with dropbox config
    session[:request_db_session] = dbsession.serialize # serialize and save this DropboxSession
    redirect_to dbsession.get_authorize_url url_for(:controller => :accesstokens, :action => :index) # pass to get_authorize_url a callback url that will return the user here
  end
end