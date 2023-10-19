class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.text :text

      t.timestamps
    end
  end
end
