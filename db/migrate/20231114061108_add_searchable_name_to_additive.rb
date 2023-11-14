class AddSearchableNameToAdditive < ActiveRecord::Migration[7.0]
  def change
    add_column :additives, :searchable_names, :text, array: true, default: []
  end
end
