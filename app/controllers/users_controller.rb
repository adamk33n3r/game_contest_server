class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  before_action :ensure_user_logged_in, :only => [:edit, :update]
  before_action :ensure_correct_user, :only => [:edit, :update]
  
  def find_user
    @user = User.find_by_username(params[:id])
  end
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(accept_params)
    if @user.save
      flash[:success] = "Welcome, #{@user.username.titleize}!"
      cookies[:logged] = true
      cookies[:user] = @user.username
      cookies.signed[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(accept_params)
      flash[:success] = "Yay you did it!"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    redirect_to users_path
  end
  
  private
  def accept_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
  
  def ensure_user_logged_in
    flash[:warning] = "Unable"
    redirect_to login_path unless logged_in?
  end
  
  def ensure_correct_user
    redirect_to root_path unless current_user? User.find_by_username(params[:id])
  end
  
  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
