# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Destroy all existing records
Additive.destroy_all
Allergen.destroy_all

puts "Destroying all current additives and allergens"
puts "Creating new additives and allergens..."

# Define a time variable
time = Time.now

# Create new Additive records
10.times do
  additive = Additive.new(
    name: Faker::Name.name,
    created_at: time,
    updated_at: time,
    information: Faker::Lorem.paragraph(sentence_count: rand(2..5)),
    danger_level: Faker::Number.between(from: 0.0, to: 4.0)
  )
  additive.save
end

#allergens
allergen_data = JSON.parse(File.read(Rails.root.join('db/seeds/allergens.json')))

allergen_data.each do |data|
  Allergen.create(data)
end

# Create new Allergen records
# 10.times do
#   allergen = Allergen.new(
#     name: Faker::Name.name,
#     created_at: time,
#     updated_at: time,
#     information: Faker::Lorem.paragraph(sentence_count: rand(2..5))
#   )
#   allergen.save
# end

puts "#{Additive.count} Additives created"
puts "#{Allergen.count} Allergens created"
