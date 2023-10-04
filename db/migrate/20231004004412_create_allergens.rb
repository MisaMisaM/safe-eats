class CreateAllergens < ActiveRecord::Migration[7.0]
  def change
    create_table :allergens do |t|
      t.string :name
      t.text :information

      t.timestamps
    end
  end
end
