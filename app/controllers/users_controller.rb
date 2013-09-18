class UsersController < ApplicationController
    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:username])
      @user.save
    end
end
