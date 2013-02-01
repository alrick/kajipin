class ApplicationController < ActionController::Base
  protect_from_forgery

  # Handle access denied
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "You're trying to see something you're not allowed to, <strong>Little Wrongdoer!</strong>"
    redirect_to edit_user_registration_url, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
   user_path(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_name)
  end
end