class User < ApplicationRecord
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze
  FILENAME_REGEXP = Regexp.union(/.\.png$/i, /.\.jpg$/i, /.\.jpeg$/i, /.\.gif$/i)

  authenticates_with_sorcery!

  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates_presence_of :username, :email

  validates :email, uniqueness: true, format: EMAIL_REGEXP
  validates :username, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }, on: :update
  validates :gender, inclusion: { in: %w[f m] }, allow_nil: true

  validates_length_of :username, :firstName, :lastName, :email, :country, :city, :maximum => 255
end
