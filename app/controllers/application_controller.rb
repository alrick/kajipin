class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_name)
  end
end
