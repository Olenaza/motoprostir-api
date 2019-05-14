class User < ApplicationRecord
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze
  FILENAME_REGEXP = Regexp.union(/.\.png$/i, /.\.jpg$/i, /.\.jpeg$/i, /.\.gif$/i)

  authenticates_with_sorcery!

  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  validates_presence_of :username, :email

  validates :email, uniqueness: true, format: EMAIL_REGEXP
  validates :username, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }, on: :update
  validates :gender, inclusion: { in: %w[f m] }, allow_nil: true

  validates_length_of :username, :firstName, :lastName, :email, :country, :city, :maximum => 255

  def follow(user_id)
    following_relationships.find_or_create_by(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id)&.destroy
  end
end
