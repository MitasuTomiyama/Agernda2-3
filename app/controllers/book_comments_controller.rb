class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
    @comment.save
    redirect_back(fallback_location: root_path)
    else
      @booknew = Book.new
	    @book_comment = BookComment.new
      @bookcomments = BookComment.all
      render "books/show"
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    # binding.pry
    @comment = BookComment.find(params[:id])
    # @comment.user_id == current_user.id
      # if
         @comment.destroy
         redirect_back(fallback_location: root_path)
    # end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
