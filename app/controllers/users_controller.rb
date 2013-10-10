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
    @user = User.new(:username => user[:username], :password => user[:password], :password_confirmation => user[:password_confirmation], :email => user[:email])
    #if @user.valid? then
    if @user.save
      flash[:success] = "Yay you did it, " + @user.username + "!"
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(accept_params)
      flash[:success] = "Yay you did it, " + @user.username + "!"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to users_path
  end
end
