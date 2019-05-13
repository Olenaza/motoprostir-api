class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :markers

  validates_presence_of :user, :title, :ride_style, :speed

  validates :title, length: { maximum: 255 }

  validates :description, presence: true, length: { minimum: 5 }

  validates :speed, numericality: { only_integer: true }

  validates_each :start_date, :end_date do |record, attr, value|
    record.errors.add(attr, 'can\'t be in the past') if value.present? && value < Date.today
  end
end
