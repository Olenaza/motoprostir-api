class Category < ApplicationRecord
  has_many :posts

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 255 }
end