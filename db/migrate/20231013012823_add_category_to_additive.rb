class AddCategoryToAdditive < ActiveRecord::Migration[7.0]
  def change
    add_column :additives, :category, :string
  end
end
