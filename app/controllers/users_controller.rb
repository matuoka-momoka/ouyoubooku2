class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
   if @user.id == current_user.id
    render :edit
   else
    redirect_to user_path(current_user.id)
   end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "You have updated user successfully."
    else
      render "show"
    end
  end
  
  def change
  add_index :users, :email, unique: true
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end