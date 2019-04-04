class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable

  validates :user, presence: true

  validates_presence_of :title, :description
end