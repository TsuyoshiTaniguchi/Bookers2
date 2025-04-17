class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
    @book = Book.new  #フォームのためのインスタンス変数
    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to users_path
    else
      @books = @user.books.page(params[:page])
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user 
  end

  def edit
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to users_path
    elsif @user != current_user
      flash[:alert] = "Not authorized to edit this profile."
      redirect_to user_path(current_user)
    end
  end


  def custom_action
    @user = User.find(params[:id]) # IDからユーザーを検索
    if @user.update(user_params)   # ユーザー情報を更新
      redirect_to @user, notice: "ユーザー情報が更新されました"
    else
      render :edit
    end
  end


  def update
    puts "Request method: #{request.request_method}"  # HTTPメソッドを確認
    puts "Received params: #{params.inspect}"  # 送信されたデータを確認
  
    @user = User.find(params[:id])
  
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user)
      else
        flash[:error] = "There was an error updating the user profile."
        render :edit
      end
    else
      flash[:alert] = "Not authorized to update this profile."
      redirect_to user_path(@user)
    end
  end


private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


end
