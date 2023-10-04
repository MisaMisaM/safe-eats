class Allergen < ApplicationRecord
  has_many :ingredients
  validates :name, :information, presence: true
  validates :name, uniqueness: true
end
