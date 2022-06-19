class UsersController < ApplicationController

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
        flash[:notice] = "User was created successfully."
    else
        render 'new', status: :unprocessable_entity
    end
  end



    def new
        @user = User.new
      end
 
  end 