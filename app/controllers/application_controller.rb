class ApplicationController < ActionController::Base
  protect_from_forgery

  # Handle access denied
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "You're trying to do something you're not allowed to, <strong>Little Wrongdoer!</strong>"
    redirect_to edit_user_registration_url, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
   user_path(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_name)
  end

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
end