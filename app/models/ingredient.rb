class Ingredient < ApplicationRecord
  belongs_to :additive
  belongs_to :allergen
end
