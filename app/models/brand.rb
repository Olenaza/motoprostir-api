class Brand < ApplicationRecord
  has_many :models

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
end