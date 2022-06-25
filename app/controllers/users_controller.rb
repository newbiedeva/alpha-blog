class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

 
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "User was created successfully."
        redirect_to articles_path
    else
        render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
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

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

 
end 