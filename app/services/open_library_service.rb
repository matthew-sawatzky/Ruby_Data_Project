require 'net/http'
require 'json'

class OpenLibraryService
  BASE_URL = "https://openlibrary.org/search.json"

  def fetch_books(query)
    uri = URI("#{BASE_URL}?q=#{query}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)['docs']
  end

  def import_books(query)
    fetch_books(query).each do |book_data|
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

  def import_fantasy_books
    import_books('fantasy')
  end

  def import_scifi_books
    import_books('science fiction')
  end

  def import_mystery_books
    import_books('mystery')
  end

  def import_nonfiction_books
    import_books('nonfiction')
  end
  def import_all_books
    import_fantasy_books
    import_scifi_books
    import_mystery_books
    import_nonfiction_books
  end
end

