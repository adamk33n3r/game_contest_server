class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  before_action :ensure_user_logged_in, :only => [:edit, :update]
  before_action :ensure_correct_user, :only => [:edit, :update]
  before_action :ensure_admin, :only => [:destroy]
  
  def find_user
    @user = User.find_by_id(params[:id])
  end
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  def new
    if logged_in?
      flash[:warning] = "You must be logged out to make a new account."
      redirect_to root_path
    else
      @user = User.new
    end
  end
  
  def create
    if logged_in?
      flash[:warning] = "You must be logged out to make a new account."
      redirect_to root_path
    else
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
  end
  
  def edit
  end
  
  def update
    if @user.update(accept_params)
      flash[:success] = "Sucessfully updated #{@user.username.titleize}!"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    if @user.admin?
      redirect_to root_path
      flash[:danger] = "Can't delete admin."
      return
    end
    if @user.username == current_user.username
      redirect_to root_path
    else
      redirect_to users_path
    end
    if @user.destroy
      flash[:success] = "Successfully deleted user."
    else
      flash[:danger] = "Error in destroy."
    end
  end
  
  private
  def accept_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
  
  def ensure_user_logged_in
    unless logged_in?
      flash[:warning] = "Required to be logged in."
      redirect_to login_path
    end
  end
  
  def ensure_correct_user
    unless current_user? User.find_by_id(params[:id])
      flash[:danger] = "Not correct user."
      redirect_to root_path
    end
  end
  
  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
