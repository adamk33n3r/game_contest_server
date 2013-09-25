class UsersController < ApplicationController
  def index
  end
  def show
    @user = User.find_by_id(params[:id])
  end
  def new
    @user = User.new
  end
  
  def create
    accept_params = params.require(:user).permit(:username, :password, :password_confirmation, :email)
    @user = User.new(accept_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
  
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to users_path
  end
end
