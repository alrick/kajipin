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
    @accesstoken.account = "alrick"
    @accesstoken.value = "asdfasdfasdf"

    if @accesstoken.save
      redirect_to services_url, notice: "<strong>#{@accesstoken.fancy_name}</strong> account successfully linked."
    else
      redirect_to services_url, alert: "<strong>Oh snap!</strong> We've failed linking your <strong>#{@accesstoken.fancy_name}</strong> account, please try again."
    end
  end

end
