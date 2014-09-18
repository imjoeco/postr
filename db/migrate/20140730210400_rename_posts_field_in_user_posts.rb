class RenamePostsFieldInUserPosts < ActiveRecord::Migration
  def change
    rename_column :user_post_lists, :posts, :items
  end
end
