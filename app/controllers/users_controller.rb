class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  before_action :ensure_user_logged_in, :only => [:edit, :update]
  before_action :ensure_correct_user, :only => [:edit, :update]
  before_action :ensure_admin, :only => [:destroy]
  
  respond_to :html, :json, :xml
  
  def find_user
    @user = User.find_by_id(params[:id])
  end
  
  def index
    @users = User.all
    respond_with(@users)
  end
  
  def show
    respond_with(@user)
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
    if !current_user? @user
      redirect_to users_path
      cookies.delete :user_id
      if @user.destroy
        flash[:success] = "Successfully deleted user."
      else
        flash[:danger] = "Error in destroy."
      end
    else
      flash[:danger] = "Can't delete yourself."
      redirect_to root_path
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
    unless current_user.admin?
      flash[:danger] = "You don't have those admin permissions, dawg!"
      redirect_to root_path 
    end
  end
end
