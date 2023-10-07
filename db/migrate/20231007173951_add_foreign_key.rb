class AddForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_column :allergens, :additive_id, :integer
    add_foreign_key :allergens, :additives
  end
end
