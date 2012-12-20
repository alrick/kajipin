require 'dropbox_sdk' # SDK needed to use Dropbox's API

class AccesstokensController < ApplicationController
  before_filter :authenticate_user!

  def index
    Dropboxtoken.dropbox_authorization
    # Get all tokens of user
    @accesstokens = current_user.accesstokens.all

    # Some var to display add buttons or not
    @has_dropbox = Accesstoken.has_token_type(current_user, Dropboxtoken.sti_name)
    @has_twitter = Accesstoken.has_token_type(current_user, Twittertoken.sti_name)
    @has_facebook = Accesstoken.has_token_type(current_user, Facebooktoken.sti_name)
  end

  def destroy
    @accesstoken = Accesstoken.find(params[:id])
    @accesstoken.destroy

    redirect_to services_url, notice: "<strong>#{@accesstoken.fancy_name}</strong> was successfully removed from your services."
  end

  def create
    @accesstoken = params[:type].constantize.new # Get type of accesstoken and init it with the right model class
    @accesstoken.user_id = current_user.id
    @accesstoken.account = "alrick"
    @accesstoken.value = "asdfasdfasdf"

    if @accesstoken.save
      redirect_to services_url, notice: "<strong>#{@accesstoken.fancy_name}</strong> account successfully linked."
    else
      redirect_to services_url, alert: "<strong>Oh snap!</strong> We've failed linking your <strong>#{@accesstoken.fancy_name}</strong> account, please try again."
    end
  end

  # Main func for Dropbox link
  def dropbox
    # Check if session init or not
    if not params[:oauth_token]
      dropbox_authorization
    else # the user has returned from Dropbox
      dbsession = dropbox_get_token
      begin
        @value = dbsession.serialize
      rescue Exception => e
        redirect_to services_url, alert: "<strong>Oh snap!</strong> We've failed linking your Dropbox account, please try again."
        return
      end
      @ilk = Appetizer.dropbox_token
      create
    end
  end

  # Create token with Dropbox
  def dropbox_authorization
    dbsession = DropboxSession.new(Appetizer.dropbox_appkey, Appetizer.dropbox_appsecret) # init session with dropbox config
    session[:request_db_session] = dbsession.serialize # serialize and save this DropboxSession
    redirect_to dbsession.get_authorize_url url_for(:controller => :accesstokens, :action => :dropbox) # pass to get_authorize_url a callback url that will return the user here
  end

  # Get access token for user
  def dropbox_get_token
    dbsession = DropboxSession.deserialize(session[:request_db_session])
    dbsession.get_access_token  # we've been authorized, so now request an access_token
    session.delete(:request_db_session) # we delete the session because we will store it in DB
    return dbsession
  end

  # Get dropbox client which allow manipulation
  def dropbox_get_client
    begin
      dbsession = DropboxSession.deserialize(@dropbox_token.value) #get accesstoken for the current user
      client = DropboxClient.new(dbsession, Appetizer.dropbox_accesstype) #raise an exception if session not authorized
      return client
    rescue Exception => e
      redirect_to services_url, alert: "<strong>Oh snap!</strong> Something went wrong with your Dropbox. If it repeats, try to delete and relink your Dropbox account."
      return
    end
  end

  # Get account name for Dropbox
  def dropbox_get_accountname
    client = dropbox_get_client
    info = client.account_info #look up account information
    return info["display_name"]
  end

end
