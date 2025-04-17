class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!, except: [:top, :index,]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_book_new


  def after_sign_in_path_for(resource)
    flash[:success] = "Signed in successfully."
    user_path(current_user.id)  # ログイン後はユーザー一覧へ
  end

  def after_sign_out_path_for(resource)
    flash[:success] = "Signed out successfully."
    root_path  # ログアウト後はトップページへ
  end
  
  

  def after_sign_up_path_for(resource)
    flash[:success] = "Welcome! You have signed up successfully."
    user_path(resource)  # ユーザーの新規登録
  end



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :profile_image])
  end

  def set_book_new
    @book_new = Book.new
  end

end
