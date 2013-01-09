class AccesstokensController < ApplicationController
  before_filter :authenticate_user!

  def index
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
    
    
    redirect_to @accesstoken.oauth_token(url_for(:action => "index"))
    
    # if params[:oauth_token] then
    #   result = request_token.get_access_token(:oauth_verifier => oauth_token)
    #   return
    # else
    #   consumer = Dropbox::API::OAuth.consumer(:authorize)
    #   request_token = consumer.get_request_token
    #   redirect_to request_token.authorize_url(:oauth_callback => url_for(:action => "create"))
    #   # Here the user goes to Dropbox, authorizes the app and is redirected
    #   return
    # end
    #@accesstoken.user_id = current_user.id
    #@accesstoken.account = "alrick"
    #@accesstoken.value = "asdfasdfasdf"

    
    # if @accesstoken.save
    #   redirect_to accesstokens_url, notice: "<strong>#{@accesstoken.fancy_name}</strong> account successfully linked."
    # else
    #   redirect_to accesstokens_url, alert: "<strong>Oh snap!</strong> We've failed linking your <strong>#{@accesstoken.fancy_name}</strong> account, please try again."
    # end
  end

  def dropbox
    if params[:oauth_token] then
      result = session[:request_token].get_access_token(:oauth_verifier => params[:oauth_token])
      redirect_to accesstokens_url, notice: "#{result.token}, #{result.secret}"
    else
      consumer = Dropbox::API::OAuth.consumer(:authorize)
      session[:request_token] = consumer.get_request_token
      redirect_to session[:request_token].authorize_url(:oauth_callback => url_for(:action => "dropbox"))
    end
  end

end
