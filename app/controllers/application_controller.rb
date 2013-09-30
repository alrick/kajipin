# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_gon_current_user

  # Allow to access current user from javascript
  def set_gon_current_user
    if user_signed_in?
      gon.current_user_name = current_user.first_name + " " + current_user.last_name
      gon.current_user_email = current_user.email
    end
  end

  # Override devise current user to allow heralds
  def devise_current_user
    @devise_current_user ||= warden.authenticate(:scope => :user)
  end
  def current_user
    if params[:key].blank?
      devise_current_user
    else
      herald = Herald.find_by_key(params[:key]) || not_found
    end   
  end

  # Cancan custom access denied
  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403", formats: [:html], status: 403,
      layout: false
  end

  # Custom devise sign in path
  def after_sign_in_path_for(resource)
   user_path(resource)
  end

  # Custom devise sign out path
  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_name)
  end

  # Used to render beautifully formatted errors
  def beautiful_errors(object)
    if object.errors.empty?
      "."
    else
      errors = object.errors.full_messages
      message = " :<ul class=\"no-bottom-margin\">"
        errors.each do |e|
          message = message + "<li>" + e + "</li>"
        end
      message = message + "</ul>"
    end
  end

  # Easily return a 404 page
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

end