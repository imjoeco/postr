class RenamePostTopDailyList < ActiveRecord::Migration
  def change
    rename_table :post_top_daily_lists, :post_daily_lists
  end
end
