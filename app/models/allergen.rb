class Allergen < ApplicationRecord
  has_many :ingredients
  has_many :additives

  validates :name, presence: true
  validates :name, uniqueness: true
end
