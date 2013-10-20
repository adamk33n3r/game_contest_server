class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_username params[:username]
    if @user && @user.authenticate(params[:password])
      flash[:success] = "Welcome, #{@user.username.titleize}!"
      cookies[:logged] = true
      cookies[:user] = @user.username
      cookies.signed[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = "Invalid username or password"
      render :new
    end
  end
  
  def destroy
    @current_user = nil
    cookies.delete :user_id
    cookies.delete :logged
    cookies.delete :user
    redirect_to login_path
  end
end
