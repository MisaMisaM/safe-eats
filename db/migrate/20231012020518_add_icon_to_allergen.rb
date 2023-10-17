class AddIconToAllergen < ActiveRecord::Migration[7.0]
  def change
    add_column :allergens, :icon, :string
  end
end
