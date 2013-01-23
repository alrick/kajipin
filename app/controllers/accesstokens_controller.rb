class AccesstokensController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    @accesstoken = Accesstoken.find(params[:id])
    @accesstoken.destroy

    redirect_to edit_user_registration_url, notice: "<strong>Dropbox</strong> was successfully removed from your services."
  end

  def create(token, secret, account)
    @accesstoken = Accesstoken.new
    @accesstoken.user_id = current_user.id
    @accesstoken.token = token
    @accesstoken.secret = secret
    @accesstoken.account = account

    if @accesstoken.save
      redirect_to edit_user_registration_url, notice: "<strong>Dropbox</strong> successfully added."
    else
      redirect_to edit_user_registration_url, alert: "<strong>Oh snap!</strong> Something went wrong during process, please try again later."
    end
  end

  def authorize
    # User has already authorized Kajipin
    if params[:oauth_token] then
      result = session[:request_token].get_access_token(:oauth_verifier => params[:oauth_token])
      account = get_account_name(result)
      token = result.token
      secret = result.secret

      create(token,secret,account)
    # User hasn't authorized Kajipin yet
    else
      # User has denied!
      if params[:not_approved]
        redirect_to edit_user_registration_url, alert: "<strong>Oh snap!</strong> You haven't authorized Kajipin on Dropbox."
      else
        consumer = Dropbox::API::OAuth.consumer(:authorize)
        session[:request_token] = consumer.get_request_token
        redirect_to session[:request_token].authorize_url(:oauth_callback => url_for(:action => "authorize"))
      end
    end
  end

  def get_account_name(access)
    begin
      client = Dropbox::API::Client.new :token => access.token, :secret => access.secret
      account = client.account
      account["email"]
    rescue Exception => e
      redirect_to edit_user_registration_url, alert: "<strong>Oh snap!</strong> Something went wrong with Dropbox, please try again later or remove and add again your account."
    end
  end

end