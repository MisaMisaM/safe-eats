class AddDisplayNameToAdditive < ActiveRecord::Migration[7.0]
  def change
    add_column :additives, :display_name, :string
  end
end
