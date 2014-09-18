class RenamePostsToItemsInPtdl < ActiveRecord::Migration
  def change
    rename_column :post_top_daily_lists, :posts, :items
  end
end
