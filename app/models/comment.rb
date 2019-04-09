class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates_presence_of :user, :text, :commentable_type, :commentable_id

  validates :text, length: { maximum: 255 }
  validates :commentable_id, numericality: { only_integer: true }
  validates :commentable_type, inclusion: { in: %w[Event Post] }
end