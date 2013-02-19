class LogpagesController < ApplicationController
  # Devise authenticate
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource :pin
  load_and_authorize_resource :logpage, :through => :pin
  
  def index
    @logpages = @pin.logpages.page(params[:page]).per(10)

    respond_to do |format|
      format.js
    end
  end

  def create
    @logpage = @pin.logpages.build(params[:logpage])
    @logpage.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @logpage = Logpage.find(params[:id])
    @logpage.update_attributes(params[:logpage])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @logpage = Logpage.find(params[:id])
    @logpage.destroy

    respond_to do |format|
      format.js
    end
  end

  def captain
    @logpage = @pin.logpages.build
    @logpages = @pin.logpages.all
  end

  def cancel
    @logpage = Logpage.find(params[:id])

    respond_to do |format|
      format.js
    end
  end
end