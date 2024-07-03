class ReportsController < ApplicationController
  def index
    @books_by_category = Book.group(:category).count
    @books_by_publisher = Book.group(:publisher).count
  end
end
