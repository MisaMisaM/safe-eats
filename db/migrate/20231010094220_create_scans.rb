class CreateScans < ActiveRecord::Migration[7.0]
  def change
    create_table :scans do |t|
      t.string :image_url
      t.text :text

      t.timestamps
    end
  end
end
