class CreateRecentLists < ActiveRecord::Migration
  def change
    create_table :recent_lists do |t|
      t.integer :user_id
      t.text :items

      t.timestamps
    end
    add_index :recent_lists, :user_id
  end
end
