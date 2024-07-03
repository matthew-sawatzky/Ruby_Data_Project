# app/controllers/books_controller.rb
class BooksController < ApplicationController
  def index
    if params[:search]
      @books = Book.where("title LIKE ?", "%#{params[:search]}%")
    else
      @books = Book.all
    end

    @books = @books.order(:title).page(params[:page]).per(30)
  end

  def show
    @book = Book.find(params[:id])
  end
end
