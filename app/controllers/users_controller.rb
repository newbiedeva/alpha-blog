class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

 
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
        flash[:notice] = "User was created successfully."
    else
        render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:username, :email, :password))
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
    def new
        @user = User.new
      end
 
  end 