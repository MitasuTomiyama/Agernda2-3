class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :corrent_user, only: [:edit, :updata]

  def show
	@booknew = Book.new
	@book = Book.find(params[:id])
	@book_comment = BookComment.new
	@bookcomments = @book.book_comments
	# @user = User.find(@book.user_id)
  end

  def index
	@booknew = Book.new
	@books = Book.all 
	@user = current_user
	# @book = Book.find(params[:id])
  end

  def create
	@book = Book.new(book_params) 
	@book.user_id = current_user.id
	if @book.save 
	   flash[:notice] = "successfully created book!"
       redirect_to book_path(@book) 
  	else
		@books = Book.all
		@user = current_user
  		render action: :index
  	end
  end

  def edit
	@book = Book.find(params[:id])
  end

  def update
	@book = Book.find(params[:id])
	@book.user_id = current_user.id
	if @book.update(book_params)
	   flash[:notice] = "successfully updated book!"
  	   redirect_to book_path(@book)
  	else 
  	   render action: :edit
  	end
  end

  def destoy
  	@book = Book.find(params[:id])
	@book.destoy
	flash[:notice] = "successfully delete book!"
  	redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def corrent_user
	book = Book.find(params[:id])
	if current_user.id != book.user_id
	   redirect_to books_path
	end
  end

end
