class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, as: :commentable

  validates_presence_of :user, :title, :description, :category

  validates :title, length: { minimum: 2, maximum: 255 }
  validates :description, length: { minimum: 5 }
end