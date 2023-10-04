class CreateAdditives < ActiveRecord::Migration[7.0]
  def change
    create_table :additives do |t|
      t.string :name
      t.text :information
      t.float :danger_level

      t.timestamps
    end
  end
end
