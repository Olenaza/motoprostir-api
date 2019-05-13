class Marker < ApplicationRecord
  belongs_to :event

  validates :lat, presence: true
  validates :lng, presence: true
  validates :draggable, inclusion: { in: [true, false] }, on: :update
end