class CreateUserCommentLists < ActiveRecord::Migration
  def change
    create_table :user_comment_lists do |t|
      t.integer :user_id
      t.text :items
      t.integer :low_karma

      t.timestamps
    end
    add_index :user_comment_lists, :user_id
  end
end
