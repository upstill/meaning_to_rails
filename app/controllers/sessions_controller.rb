class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  def new
    session[:return_to] = params[:return_to] if params[:return_to]
  end

  def create
    user = User.find_by(name: (params[:name] || params[:username]))
    if user && user.authenticate_via_identity(params[:password])
      session[:user_id] = user.id
      redirect_to(session.delete(:return_to) || root_url)
    elsif user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/' # login_url
  end
end
