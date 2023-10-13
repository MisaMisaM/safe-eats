class AddPurposeToAdditive < ActiveRecord::Migration[7.0]
  def change
    add_column :additives, :purpose, :string
  end
end
