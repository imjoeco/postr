class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.string :user_name
      t.integer :karma

      t.timestamps
    end
    add_index :comments, :user_id
  end
end
