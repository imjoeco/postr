class CreatePostFavorites < ActiveRecord::Migration
  def change
    create_table :post_favorites do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_index :post_favorites, :user_id
    add_index :post_favorites, :post_id
  end
end
