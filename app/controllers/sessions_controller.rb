class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_username params[:username]
    if @user && @user.authenticate(params[:password])
      flash[:success] = "#{@yser} logged in."
      session[:logged] = true
      session[:user] = @user.username
      redirect_to @user
    else
      flash.now[:danger] = "Invalid username or password"
      render :new
    end
  end
  
  def destroy
    session[:logged] = nil
    session[:user] = nil
    redirect_to root_path
  end
end
