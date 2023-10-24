class Scan < ApplicationRecord
  has_one_attached :image_url
  has_one :result
end
