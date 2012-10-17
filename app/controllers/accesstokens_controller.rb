class AccesstokensController < ApplicationController

  def index
    @user = current_user
    @accesstokens = Accesstoken.all
  end
end
