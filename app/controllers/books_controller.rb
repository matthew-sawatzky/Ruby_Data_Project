class BooksController < ApplicationController
  def index
    if params[:search]
      @books = Book.where("title LIKE ?", "%#{params[:search]}%")
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
