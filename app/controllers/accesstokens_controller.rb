require 'dropbox_sdk' # SDK needed to use Dropbox's API

class AccesstokensController < ApplicationController

  def index
    @dropbox_token = current_user.accesstokens.dropbox.first
  end

  def dropbox
    # Check if session init or not
    if not params[:oauth_token]
      dbsession = DropboxSession.new(Appetizer.dropbox_appkey, Appetizer.dropbox_appsecret) # init session with dropbox config
      session[:request_db_session] = dbsession.serialize # serialize and save this DropboxSession
      redirect_to dbsession.get_authorize_url url_for(:action => :dropbox) # pass to get_authorize_url a callback url that will return the user here
    else # the user has returned from Dropbox
      dbsession = DropboxSession.deserialize(session[:request_db_session])
      dbsession.get_access_token  # we've been authorized, so now request an access_token
      session.delete(:request_db_session) # we delete the session because we will store it in DB

      token = Accesstoken.new(:value => dbsession.serialize, :ilk => Appetizer.dropbox_token, :user_id => current_user.id) # Init token with values
      if token.save
        redirect_to services_url, notice: "Dropbox account successfully linked."
      else
        redirect_to services_url, alert: "<strong>Oh snap!</strong> We've failed linking your Dropbox account, please try again."
      end
    end
  end
end
