require 'net/http'
require 'json'

class OpenLibraryService
  BASE_URL = "https://openlibrary.org/search.json?q=books"

  def fetch_books
    uri = URI(BASE_URL)
    response = Net::HTTP.get(uri)
    JSON.parse(response)['docs']
  end

  def import_books
    fetch_books.each do |book_data|
      author = Author.find_or_create_by(name: book_data['author_name']&.first)
      publisher = Publisher.find_or_create_by(name: book_data['publisher']&.first)
      category = Category.find_or_create_by(name: book_data['subject']&.first)

      Book.create(
        title: book_data['title'],
        description: book_data['first_sentence']&.first,
        publish_date: book_data['publish_date']&.first,
        isbn: book_data['isbn']&.first,
        author: author,
        publisher: publisher,
        category: category
      )
    end
  end
end
