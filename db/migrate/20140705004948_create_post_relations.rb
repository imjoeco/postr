class CreatePostRelations < ActiveRecord::Migration
  def change
    create_table :post_relations do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :voted
      t.integer :comment_count
      t.text :voted_comments

      t.timestamps
    end
    add_index :post_relations, :user_id
    add_index :post_relations, :post_id
  end
end
