class User < ApplicationRecord
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze

  authenticates_with_sorcery!

  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates_presence_of :username, :firstName, :lastName, :email, :gender, :country, :city, :admin

  validates :email, uniqueness: true, format: EMAIL_REGEXP
  validates :username, uniqueness: true

  # Don't use validates_associated on both ends of your associations. They would call each other in an infinite loop.
  validates_associated :events, :posts

  validates_length_of :username, :firstName, :lastName, :email, :country, :city, :maximum => 255

end
