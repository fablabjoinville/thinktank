class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def access_denied(exception)
    if user_signed_in?
      redirect_to(dashboard_path, alert: exception.message)
    else
      redirect_to(new_user_session_path, alert: exception.message)
    end
  end
end
