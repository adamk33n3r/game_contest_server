class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  
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
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(accept_params)
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    redirect_to users_path
  end
  
  def accept_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
