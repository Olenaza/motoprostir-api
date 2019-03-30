class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :user, presence: true
  validates_presence_of :text, :commentable_id, :commentable_type
end