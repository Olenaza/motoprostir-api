class Model < ApplicationRecord
  belongs_to :brand

  validates_presence_of :name
end