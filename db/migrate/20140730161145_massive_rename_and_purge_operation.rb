class MassiveRenameAndPurgeOperation < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :top_comments
    remove_column :user_profiles, :latest_activities
    remove_column :user_profiles, :top_posts
    remove_column :user_profiles, :favorite_posts
    remove_column :post_favorites, :title

    remove_index :recent_lists, :user_id
    remove_index :post_lists, :user_id
    remove_index :favorite_lists, :user_id

    rename_table :recent_lists, :user_recent_lists
    rename_table :post_lists, :user_post_lists
    rename_table :favorite_lists, :user_favorite_lists

    add_index :user_recent_lists, :user_id
    add_index :user_post_lists, :user_id
    add_index :user_favorite_lists, :user_id
  end
end
