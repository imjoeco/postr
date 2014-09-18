class CreateFavoriteLists < ActiveRecord::Migration
  def change
    create_table :favorite_lists do |t|
      t.integer :user_id
      t.text :items

      t.timestamps
    end
    add_index :favorite_lists, :user_id
  end
end
