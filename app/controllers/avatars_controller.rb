# encoding: utf-8
class AvatarsController < ApplicationController
  # Devise authenticate
  before_filter :authenticate_user!

  # Cancan authorize
  load_and_authorize_resource

  def new
    @key = ENV["FILEPICKER_KEY"]

    respond_to do |format|
      format.js
    end
  end

  def create
    if remove_current
      @avatar = Avatar.new(params[:avatar])
      @avatar.handle = @avatar.url.split("/").last
      @avatar.user_id = current_user.id

      if @avatar.save
        flash[:notice] = t('avatars.create.success')
      else
        flash[:alert] = t('avatars.create.fail')+beautiful_errors(@avatar)
      end
    else
      flash[:alert] = t('avatars.create.fail')+beautiful_errors(@avatar)
    end

    # Respond with javascript because it's ajax request
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @avatar = Avatar.find(params[:id])
    @avatar.destroy

    redirect_to edit_user_registration_url, notice: t('avatars.destroy.success')
  end

  # Destroy current avatar before setting a new one
  def remove_current
    if !current_user.avatar.nil?
      current_user.avatar.destroy
    else
      true
    end
  end

end