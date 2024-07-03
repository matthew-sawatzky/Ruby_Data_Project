class BooksController < ApplicationController
  def index
    if params[:search].present?
      @books = Book.joins(:author, :publisher, :category)
                   .where("books.title ILIKE ? OR authors.name ILIKE ? OR publishers.name ILIKE ? OR categories.name ILIKE ?", 
                          "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
                   .includes(:author, :publisher, :category)
                   .page(params[:page])
    else
      @books = Book.includes(:author, :publisher, :category).page(params[:page])
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
