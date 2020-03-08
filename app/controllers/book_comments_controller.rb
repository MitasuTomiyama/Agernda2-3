class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    # if @comment.save
    @comment.save
    redirect_back(fallback_location: root_path)
    # else
    #   @booknew = Book.new
	  #   @book_comment = BookComment.new
    #   @bookcomments = BookComment.all
    #   render "books/show"
    # end
  end

  def destroy
    comment = book.book_comment.find(params[:id])
    if book_comment_user_id == current_user
      comment.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
