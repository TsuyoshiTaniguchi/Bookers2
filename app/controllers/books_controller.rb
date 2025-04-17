class BooksController < ApplicationController
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    books_path
  end
  

  def new
    @book = Book.new(title: "", body: "")  # 初期値を空に設定
  end


  def create
    puts "Received params: #{params.inspect}"  # デバッグ用
  
    @book = Book.new(book_params)
    @book.user = current_user
    @user = current_user
    @books = Book.all
  
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      puts @book.errors.full_messages
      flash[:alert] = @book.errors.full_messages.join(", ") # エラーメッセージを統一
      redirect_to books_path # 失敗時も /books にリダイレクト
    end
  end


  def index
    @books = Book.all
    @book_new = Book.new  # 新規投稿用のオブジェクト
    @user = current_user
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new  # 新規投稿用のオブジェクト
    @books = Book.all
  end


  def edit
    @book = Book.find(params[:id])
  
    if @book.user != current_user
      flash[:alert] = "You are not authorized to edit this book."
      redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book information updated successfully!" # フラッシュメッセージ設定
      redirect_to @book  # 詳細ページなどにリダイレクト
    else
      flash[:alert] = "Failed to update book information."
      render :edit
    end
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end


end

