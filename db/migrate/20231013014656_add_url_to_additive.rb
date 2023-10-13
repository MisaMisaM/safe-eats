class AddUrlToAdditive < ActiveRecord::Migration[7.0]
  def change
    add_column :additives, :url, :string
  end
end
