class LogpagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_pin

  def index
    @logpages = @pin.logpages.order("created_at ASC")

    respond_to do |format|
      format.js
    end
  end

  def update
    @logpage = Logpage.find(params[:id])

    respond_to do |format|
      if @logpage.update_attributes(params[:logpage])
        flash[:notice] = 'Logpage was successfully updated.'
        format.html { redirect_to manage_pin_logpages_url(@pin) }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def destroy
    @logpage = Logpage.find(params[:id])
    @logpage.destroy

    respond_to do |format|
      format.html { redirect_to manage_pin_logpages_url(@pin) }
      format.xml  { head :ok }
    end
  end

  def manage
    @logpages = @pin.logpages.order("created_at ASC")
  end

  # Get the pin the comment belongs to (nested)
  def get_pin
    @pin = Pin.find(params[:pin_id])
  end
end
