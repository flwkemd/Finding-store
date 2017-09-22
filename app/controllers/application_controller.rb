class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :require_login
  
  protected 
  
  def require_login
    @logined_user = logged_in?
    if not @logined_user
      redirect_to controller: 'user', action: 'login_form'
    end
  end

  def logged_in?
    if session[:logined]
      current_user = session[:user]
      return current_user
    end
    return false
  end
end