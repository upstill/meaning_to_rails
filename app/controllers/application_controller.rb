class ApplicationController < ActionController::Base
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def root
    redirect_to (current_user ? '/list_items/index' : '/sessions/new')
  end

end
