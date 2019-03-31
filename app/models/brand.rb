class Brand < ApplicationRecord
  has_many :models

  validates_presence_of :name
end