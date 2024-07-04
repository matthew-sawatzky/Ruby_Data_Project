class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  belongs_to :category

  validates :title, presence: true
  validates :isbn, uniqueness: true
end
