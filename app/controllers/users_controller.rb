class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, { only: [:update, :edit] }

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully"
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book  = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(@user)
    end

  end

  private
  def user_params
   params.require(:user).permit(:name, :introduction , :profile_image)
  end

  def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
