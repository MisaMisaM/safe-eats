class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.references :additive, null: false, foreign_key: true
      t.references :allergen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
