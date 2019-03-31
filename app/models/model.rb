class Brand < ApplicationRecord
  belongs_to :models

  validates_presence_of :name
end