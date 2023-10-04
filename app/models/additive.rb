class Additive < ApplicationRecord
  has_many :ingredients
  validates :name, :information, :danger_level, presence: true
  validates :name, uniqueness: true
end
