class AddFavoritePostsToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :favorite_posts, :text
  end
end
