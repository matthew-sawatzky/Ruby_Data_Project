Book.destroy_all
Author.destroy_all
Publisher.destroy_all
Category.destroy_all

OpenLibraryService.new.import_books

puts "Seeding completed!"
