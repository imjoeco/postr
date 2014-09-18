class CreatePostLists < ActiveRecord::Migration
  def change
    create_table :post_lists do |t|
      t.integer :user_id
      t.text :posts
      t.integer :low_karma

      t.timestamps
    end
    add_index :post_lists, :user_id
  end
end
