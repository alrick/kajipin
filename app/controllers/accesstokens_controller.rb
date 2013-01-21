class AccesstokensController < ApplicationController
  before_filter :authenticate_user!

  def index
    # Get all tokens of user
    @accesstokens = current_user.accesstokens.all

    # Some var to display add buttons or not
    @has_dropbox = Accesstoken.has_token_type(current_user, Dropboxtoken.sti_name)
  end

  def destroy
    @accesstoken = Accesstoken.find(params[:id])
    @accesstoken.destroy

    redirect_to accesstokens_url, notice: "<strong>#{@accesstoken.fancy_name}</strong> was successfully removed from your services."
  end

  def dropbox
    if params[:oauth_token] then
      result = session[:request_token].get_access_token(:oauth_verifier => params[:oauth_token])
      @accesstoken = Dropboxtoken.new
      @accesstoken.user_id = current_user.id
      @accesstoken.token = result.token
      @accesstoken.secret = result.secret
      @accesstoken.account = get_account_name(result.token, result.secret)
      if @accesstoken.save
        redirect_to accesstokens_url, notice: "<strong>#{@accesstoken.fancy_name}</strong> successfully added."
      else
        redirect_to accesstokens_url, alert: "<strong>Oh snap!</strong> Something went wrong during process, please try again later."
      end
    else
      consumer = Dropbox::API::OAuth.consumer(:authorize)
      session[:request_token] = consumer.get_request_token
      redirect_to session[:request_token].authorize_url(:oauth_callback => url_for(:action => "dropbox"))
    end
  end

  def get_account_name(token, secret)
    client = Dropbox::API::Client.new :token => token, :secret => secret
    account = client.account
    account["email"]
  end

end